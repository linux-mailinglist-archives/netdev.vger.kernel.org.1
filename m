Return-Path: <netdev+bounces-112712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365493AB28
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 04:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34FFB24096
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 02:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B217547;
	Wed, 24 Jul 2024 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhbcdqJ4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D91134B1
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787467; cv=none; b=OCRC6USzRDNeMrkTeTQ2ZDPdsh0ZqdpT8nRcjjlT1D1MR9aqlv1diQ1jNXlfOrnU6Gn5eUdWOxnHtcDgyv5G3+PL/k/Iz8p7Bu2FHGjMJwYj5TOCmOeNvhWXfOeWZ4q7w6y2KpzfvD9hAlAOEiKJCi9uO0Bx+wBledaocXBzaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787467; c=relaxed/simple;
	bh=HqQhCLi2BNPd/ZrfrrIBuLEUl8XjR1USS5+f0zaa3a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqrLv3ifLNAsniEXBEp5upWM+nupuvfDTtzeAIy2D1QElQB9zkxsQui2e0WOk6zlmmcjOCMcwddvlQQmdGQjUaAkPjA3AZIddvBcJUMYaHdEPozwiD223EEOTYp9BhtUKMiecIU1X9xorrmD9dh9Sclm08B2TYnDId+nSrPhPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhbcdqJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/CDtEBkZLf1xoU0C7ksliBZOQvRtEzxEPf2Wwd79pU=;
	b=UhbcdqJ47uB7R55QBJCNX9UkhPe5zZa+ZCMVbLryIDJpYV2m999ZUrNIeaEz7Kz1IXBGjO
	ULNkOruZG8KbQWb3Bc8k5akoqKrOIOZ8s+9dnWK6K9hPuid2acmJ/G4+8g84W4X0vG8HVW
	RdAuxWobGMezTGb8ROR8OXkk6P91kxE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-8RK1m8hlOW-LN6buwWOZJw-1; Tue, 23 Jul 2024 22:12:42 -0400
X-MC-Unique: 8RK1m8hlOW-LN6buwWOZJw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a7b90cb746so1772406a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 19:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787161; x=1722391961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/CDtEBkZLf1xoU0C7ksliBZOQvRtEzxEPf2Wwd79pU=;
        b=mWFJSeMjhHLHHu/CYEWfF3D+/yl4x7pBGZpjrPV9e4yfs/c29QG7eViLPb7dpIIHmn
         ZkwVAZudD+/Wel3mZLy0fyVQNA+k/BdTrSpCD8uqrFb/fV2odQmlnDnYb8QvRNiEg0Jq
         8hKShST6e1YfLHo8MOpM54VCpofAhpnMxJ/9BuIIj+M/bEM+knc+jPtL2hU66onADPPc
         rJliMPJZ7ZZE5/jYLHpGtgUOGwJ4vr/Fng7fTKisBZjdUi/k8i0ty2SvRu7XORC6i8Zf
         mIOjTUxzEA3BRmI2XnCVk+lTMc7OxHQK/f4MnmlFESn9zXb7iGVJEEprSMq0OWq8hwn1
         JOZg==
X-Forwarded-Encrypted: i=1; AJvYcCV1W/yyeasiEUb12QD/GrnedkhgPKo11esRUwHjSi6uJe3xGe4Pd9SI4JOdC1pPjaroUa0DX/dYwWEOda/woG5KvXNkrxIm
X-Gm-Message-State: AOJu0Yy5EXR5tFvRvJGWS2i+jRcZMqIItBjLbPJwBzjIV+iN16+c6LeV
	xKQNr4+0zhjg/2VzNpauDa0E2TSIjIQAM+ex6NhyHS/m1enLH3ujI8VQDC1LFduf8eoV4RYIZtw
	fgwxL20x/MwVybcOGYgt7qTZ+dbcFBcYu1DrzyANXTiqZxlyYlMN46cttff6gSxbeLdDwfsHwXI
	0EFVdntyiSeEbON8IZOTN10X9G8dnJ
X-Received: by 2002:a05:6402:234c:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5aaece39c30mr562182a12.22.1721787160874;
        Tue, 23 Jul 2024 19:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgP3SMHABHLAK1ShSJyuqULWrGb17ytiwZhc3mKrBjTl8ITd2JHGrsgEsjrJDBGLVMXv7Gi/wR2c5DVGWvAaQ=
X-Received: by 2002:a05:6402:234c:b0:5a2:abcb:c4cf with SMTP id
 4fb4d7f45d1cf-5aaece39c30mr562165a12.22.1721787160493; Tue, 23 Jul 2024
 19:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
In-Reply-To: <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:03 +0800
Message-ID: <CACLfguVQT2bpzA6zTyAV4pDRdFttCMXCZc179HqxvjCVRPNnkQ@mail.gmail.com>
Subject: Re: [PATH v5 0/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 02:45, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 23, 2024 at 01:39:19PM +0800, Cindy Lu wrote:
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address
> > to the config space. However, for other drivers, they can implement their
> > own function, not limited to the config space.
> >
> > Changelog v2
> >  - Changed the function name to prevent misunderstanding
> >  - Added check for blk device
> >  - Addressed the comments
> > Changelog v3
> >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> >  - Add a lock for the network device's dev_set_attr operation
> >  - Address the comments
> > Changelog v4
> >  - Address the comments
> >  - Add a lock for the vdap_sim?_net device's dev_set_attr operation
> > Changelog v5
> >  - Address the comments
>
> This history is to help reviewers of previous versions know if there
> comments have been addressed. Just saying 'Address the comments' is
> not useful. Please give a one line summary of each of the comment
> which has been addressed, maybe including how it was addressed.
>
>       Andrew
>
will change this
Thanks
cindy


