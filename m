Return-Path: <netdev+bounces-177301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C0A6ED0E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CC83A5AE4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1531E5B7D;
	Tue, 25 Mar 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVWVVx3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7219B5B4
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896267; cv=none; b=fH17DQN+EX7l1Jmnc55B0rtHr8re0xwu5+Bql7wWq0CqhJzHlOV1HfQWBJ8vIqLWL0JAGTM8DzDAur2BIF0sLCz0ifts+Yxf6r3D41MkZQBT8SikF1xPLu7qRik8glwC18iG1kNkc+2GtuZs07i9qIPQouXZ7F+c5Vm5vJ+dcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896267; c=relaxed/simple;
	bh=IawYsrs8weGdVP5mOwpSbt2Z7iDnmUBIne7UBChfphY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZuiOgAihPt+njbJ/q6O7tNSSil4TYGwaDRPDvWQ0TnHB2jHOnNsvGf2ooOog5oGHyEUaH1iutGQq6RzVH9LG07x6vyvEb40IUExG/wDz14DgsJYWDvBkbLtyEeWvfDGeuBZbEzNuxj01nG3yW1Q9+Sbd9Mx9FDjaJN5mbzAYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVWVVx3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3182C4CEE4;
	Tue, 25 Mar 2025 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742896265;
	bh=IawYsrs8weGdVP5mOwpSbt2Z7iDnmUBIne7UBChfphY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UVWVVx3ZlVOB1/mBGwGr+A0cabmE1Z2hivpIWLUHvwYrJqCyJ7yoNjP9kOOyKh1Sm
	 mrc3cIj82ToXVTaKdeXFHntW5NGQN1GKLavqgWAI8IVLBmb9TMpWhql1ElDBcnEtM9
	 7ePvOoPZDwusifsRcvLTUecMKIppP97GdLI7mDSLDl4i+E+SKxyivHWyv3Q4IxmXRk
	 lmbMg0tYRxjzwuDwk9aVfItGfWduK/KAQ6VxpRqZ7erzE+s8k/siGbTAe+fu70vHh8
	 pUyk0dThQuUcfQO6mHIrPEimb8dSNZohoDaSjhi64RcCDDwXxw73DWlhiAOCCLCpEC
	 Ni/VWtqSR+tVA==
Date: Tue, 25 Mar 2025 02:50:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH net-next v2 07/11] net: protect rxq->mp_params with the
 instance lock
Message-ID: <20250325025058.067517d1@kernel.org>
In-Reply-To: <CAHS8izMyS_y0o9EzJ8NaLnS99KYH+Ze6BaSw=+=hPPnuS9zP8A@mail.gmail.com>
References: <20250324224537.248800-1-kuba@kernel.org>
	<20250324224537.248800-8-kuba@kernel.org>
	<CAHS8izMyS_y0o9EzJ8NaLnS99KYH+Ze6BaSw=+=hPPnuS9zP8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 22:34:43 -0700 Mina Almasry wrote:
> > @@ -11957,9 +11957,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
> >                 dev_tcx_uninstall(dev);
> >                 netdev_lock_ops(dev);
> >                 dev_xdp_uninstall(dev);
> > +               dev_memory_provider_uninstall(dev);
> >                 netdev_unlock_ops(dev);
> >                 bpf_dev_bound_netdev_unregister(dev);
> > -               dev_memory_provider_uninstall(dev);  
> 
> So initially I thought this may be wrong because netdev_lock_ops()
> only locks if there are queue_mgmt_ops, but access to mp_params should
> be locked anyway. But I guess you're relying on the fact that if the
> device doesn't support queue_mgmt_ops memory providers don't work
> anyway.

Right, my expectation is that they must be NULL if device is not
ops-locked. Not sure if that's what textbooks would consider "correct"
but I think KCSAN will not complain :)

