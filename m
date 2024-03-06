Return-Path: <netdev+bounces-78183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B708C8743F8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5E2283568
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450CF1CA87;
	Wed,  6 Mar 2024 23:32:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220ED1B94D;
	Wed,  6 Mar 2024 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767920; cv=none; b=MvAxwy+hd5p5tLl5c82Azscbqy0uhA6dReDmFmIsXxn9UxhYk205qWb4jj2jT7dyDE5IY97CnyGUx2ZLYVh4wpQHrZjYWNKShUDyVhj2LzO3KrNGuYwdgobvVAotUU9mB3fRhYlKZPLhzL2Xo72GMtw2KSlIywt6dVVKEIjeQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767920; c=relaxed/simple;
	bh=M/Hdo/ckXi+VdiuVJ3yXuwn7VSjRydkLpL480lyENqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCJrYuNayG5ODcYfmbMBbAKgkFBXZQyDA62esrDJlynKuRQg6i2gsxOYySj3a9z+pUszVGow1LBgq2sVUhMjzkrSY/6pyWLl0eracACgx0Q3eH6wnrEZAyCmGNZHKsiFgqJIpVV/PYtQtIPmXhEueZE48E9GWpk8hLWzm6urmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50720C433C7;
	Wed,  6 Mar 2024 23:31:58 +0000 (UTC)
Date: Wed, 6 Mar 2024 18:33:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Message-ID: <20240306183351.4ebcbfdf@gandalf.local.home>
In-Reply-To: <871q8ngesa.fsf@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
	<20240223114453.335809-5-tobias@waldekranz.com>
	<20240223103815.35fdf430@gandalf.local.home>
	<4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
	<87a5nkhnlv.fsf@waldekranz.com>
	<20240228095648.646a6f1a@gandalf.local.home>
	<877cihhb7y.fsf@waldekranz.com>
	<20240306101557.2c56fbc6@gandalf.local.home>
	<874jdjgmdd.fsf@waldekranz.com>
	<20240306164626.5a11f3cd@gandalf.local.home>
	<871q8ngesa.fsf@waldekranz.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 Mar 2024 23:45:57 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> > How big is this info?  
> 
> The common struct (switchdev_notifier_info) is 24B at the
> moment. Depending on __entry->val, the size of the enclosing
> notification (e.g. switchdev_notifier_port_obj_info) is between
> 40-64B. This pattern may then repeat again inside the concrete notifier,
> where you have a pointer to a common object (e.g. switchdev_obj, 48B)
> whose outer size (e.g. switchdev_obj_port_vlan, 56B) is determined by an
> accompanying enum.

As long as it's under 1K, you should be good.

-- Steve

