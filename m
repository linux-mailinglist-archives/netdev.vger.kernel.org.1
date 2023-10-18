Return-Path: <netdev+bounces-42289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC67CE0E7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F21C20D16
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B538BBC;
	Wed, 18 Oct 2023 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO6R+J/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7438BB0
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BECC433C8;
	Wed, 18 Oct 2023 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697642022;
	bh=OtMZJC4ksDaFAbMIle5La8GtkKZfjR5M26IvH6z9TWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kO6R+J/9Pjw9QBJnmDA2dT9dlrqIiqw1mN3yDaPTh1L2g1FW0y+UZJW1nB9AvKBs3
	 QDYketdSOC0FIM/ve73XTnjD+kbXkyHsUu3Kr+W91MyvpoIB1JH4J4Q+DRpFdf3MM+
	 S/egBCRBG71SzmuRmrjLcXr9gOTG9hx+8mukHykzXzUrG6GpkE3aiwFGE+IljAOSeZ
	 Us9zKmSuUy0Y9XmKY8BypEa0pfKJ4afJEph/0VUYzkbwCWEBj79KOuIPDkxnaC8m/l
	 fuJ2LJWj1ExUHIcWaRSHLfYldLno99SOyVwP1anXX4AHl4guEF949WrOKWg1yRgt6f
	 ZDHW9K21i2FkQ==
Date: Wed, 18 Oct 2023 08:13:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com, daniel@iogearbox.net,
 opurdila@ixiacom.com
Subject: Re: [PATCH net v2 1/5] net: fix ifname in netlink ntf during netns
 move
Message-ID: <20231018081341.66bf393b@kernel.org>
In-Reply-To: <ZS+FehME4fC4b7w4@nanopsycho>
References: <20231018013817.2391509-1-kuba@kernel.org>
	<20231018013817.2391509-2-kuba@kernel.org>
	<ZS+FehME4fC4b7w4@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 09:12:58 +0200 Jiri Pirko wrote:
> >+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
> >+			       const char *want_name, char *out_name)
> >+{
> >+	int ret;
> >+
> >+	if (!dev_valid_name(want_name))
> >+		return -EINVAL;
> >+
> >+	if (strchr(want_name, '%')) {
> >+		ret = __dev_alloc_name(net, want_name, out_name);
> >+		return ret < 0 ? ret : 0;
> >+	} else if (netdev_name_in_use(net, want_name)) {
> >+		return -EEXIST;
> >+	} else if (out_name != want_name) {  
> 
> How this can happen?
> You call dev_prep_valid_name() twice:
> 	ret = dev_prep_valid_name(net, dev, name, buf);
> 	err = dev_prep_valid_name(net, dev, pat, new_name);
> 
> Both buf and new_name are on stack tmp variables.

I'm moving this code 1-to-1. I have patches queued up to clean all 
this up in net-next. Please let me know if you see any bugs.

