Return-Path: <netdev+bounces-117167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158594CF44
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FC81C20F22
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7BE15A848;
	Fri,  9 Aug 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZCnDYJ7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A61591F3
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202194; cv=none; b=p8WCth7ownsoDUS0omPiltZCEr7iOtbPreKvKH/NgHYFc1gFquncfAUHQZD3rhAIM5fwMxUctgPqhkmEmBdcBtCLWSORfp+OGJB46eWmOUyOXUUwak0yiMLr1e+wSb7st1/GHdS2XCwei1yJH+zyEN94JL5waHYz9Ka+61vqHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202194; c=relaxed/simple;
	bh=9xAqWNDO9p1w8OqFGkzTfaw8ZwLhS41odTNilT53FLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW8tcyD+gPVdrfXdPssl7NBoZcj/nPZC9A3j52zZY0vDgZFql8dRUyyOHpIAl+UyN53mwV8jp9rdIJbs0oJYRwc+EF4flEyUXyBGpMzt6H51Uj4ik9xMEQj4MaxbNIQ7xiG+ydfkIDeVHBO29mtGEkWmkulbw2tfL000JTRa7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZCnDYJ7Q; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so4557211a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723202190; x=1723806990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWIrxwmGw7XrmDwMPAneY7U5D2w8x3fp3sd7EOC/LsY=;
        b=ZCnDYJ7QjZLYUy8zsgU6HgaMRRTa4gj0ohWiPRIj7ooyMaShSfh6OnG5PNyFP4zS8c
         KVNGrCOmJEU6ngLsvvZGVAQ0ckO0hSzP6vQY9hsIe7matctlf0Nuc6Kh5eXXochB77EI
         lB5fZF7IUa476LfSXHIxYF8EauxowMFoIBhN3Fc3FTp5C7jiw5ogBv90zDToKUWWuRH/
         VDotcNj6eoyU0jATc3uUk0Ek85Z2TrBsC12+z+ccYTniZmEpNivz7NKI7MJhXzTo37DC
         UtcgmCZNixCenrv4fhQrz/kP0mLeqleGCJOmcQYfbQGXxUqBav/t4co4BVrPa8dx2qob
         47xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202190; x=1723806990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWIrxwmGw7XrmDwMPAneY7U5D2w8x3fp3sd7EOC/LsY=;
        b=Ai88IbNCFXBmgalAZrqQ+ud+jOjr7RrngLHRysnAQ3kTrTYnbl865LHgfniW27ESx4
         vUgFUSWXevI+76Y+teVvX12s9ycVjGeuH9XGLmfRExK2VHRAQNADgoBPQ1X7puXQEP1P
         /xY2kwqLhA6G9q0hA5Z6G4te8Zsthx3dIpCL8AzaaD/sfT2z53zrUXL5EzhoZ52Klo3W
         BbRYAIvY+5orUUoO+I2l6wPMa9t2UuTgDDz5Zv2nMFOFDSsJAzXBCMdVCUiq9zEUR0DA
         tKzC39PVLfiKb34+ySCejuPHpzJ1uFsYSoyj1Pwi/EAYk7/cHLE8RbjyhkXnYX+ms7si
         9WWA==
X-Forwarded-Encrypted: i=1; AJvYcCWxTz1IE+R2wxJkcWnVh4Lifr8G1Cf/46YziG6WCnA5bZpKfDTZZzkZ+9IYhwxI5B8nr06hf6hHLQUDPonGOCrZVc0cTXIF
X-Gm-Message-State: AOJu0YwB6mAqAL+yBVso1O0Ojs+MyLzxE7Is22gi2ITkTvfGP04/r2LS
	+d6rgcrXsqATmNRkGJf/idUwNjp29wv0tdInTAl+K12F0aNPIx7CcTXzNAxtG2E=
X-Google-Smtp-Source: AGHT+IHma6OrSTPXHax6dmo1PJUtU1uI469clvEXCyNculQd81yAK6fFAf6otXGP0uQgsL9r/dwqWA==
X-Received: by 2002:a17:907:2da6:b0:a6f:e0f0:d669 with SMTP id a640c23a62f3a-a8091ef4d25mr423109266b.12.1723202190311;
        Fri, 09 Aug 2024 04:16:30 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cca0sm830450466b.64.2024.08.09.04.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:16:29 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:16:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v3 03/15] ice: add basic devlink subfunctions
 support
Message-ID: <ZrX6jM6yedDNYfNv@nanopsycho.orion>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808173104.385094-4-anthony.l.nguyen@intel.com>

Thu, Aug 08, 2024 at 07:30:49PM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>

[...]

>+static int
>+ice_devlink_port_new_check_attr(struct ice_pf *pf,
>+				const struct devlink_port_new_attrs *new_attr,
>+				struct netlink_ext_ack *extack)
>+{
>+	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
>+		NL_SET_ERR_MSG_MOD(extack, "Flavour other than pcisf is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (new_attr->controller_valid) {
>+		NL_SET_ERR_MSG_MOD(extack, "Setting controller is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (new_attr->port_index_valid) {
>+		NL_SET_ERR_MSG_MOD(extack, "Port index is invalid");

Nope, it is actually valid, but your driver does not support that.
Please fix the message.


>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (new_attr->pfnum != pf->hw.bus.func) {

hw.bus.func, hmm. How about if you pass-through the PF to VM, can't the
func be anything? Will this still make sense? I don't think so. If you
get the PF number like this in the rest of the driver, you need to fix
this.



>+		NL_SET_ERR_MSG_MOD(extack, "Incorrect pfnum supplied");
>+		return -EINVAL;
>+	}
>+
>+	if (!pci_msix_can_alloc_dyn(pf->pdev)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Dynamic MSIX-X interrupt allocation is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	return 0;
>+}

[...]


>+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>+{
>+	struct devlink_port_attrs attrs = {};
>+	struct devlink_port *devlink_port;
>+	struct devlink *devlink;
>+	struct ice_vsi *vsi;
>+	struct ice_pf *pf;
>+
>+	vsi = dyn_port->vsi;
>+	pf = dyn_port->pf;
>+
>+	devlink_port = &dyn_port->devlink_port;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>+	attrs.pci_sf.pf = pf->hw.bus.func;

Same here.


>+	attrs.pci_sf.sf = dyn_port->sfnum;
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+	devlink = priv_to_devlink(pf);
>+
>+	return devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>+					   &ice_devlink_port_sf_ops);
>+}
>+

[...]

