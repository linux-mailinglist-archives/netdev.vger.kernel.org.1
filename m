Return-Path: <netdev+bounces-118489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0BB951C3F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D78B27F74
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8FB1B0125;
	Wed, 14 Aug 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KVcJLNgj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA811AD9D6
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643488; cv=none; b=NgZkM+NfplpyEXwRDhpIkl9Cyn8nNcsiIPFn3f8LzsQNz/2VsvdMD6QLeBaxKzv4NJjr6FaoPDhqhbbNP1VkcsuGndlHRnMnA6KyCYy8440yc2EPRS5IlHoMnNde24nk245AiZOt0Uu1yGaQ/QWwAIEh+eCgtZyw6KcexTYpREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643488; c=relaxed/simple;
	bh=3dQ/HGv/ji9zjO6Tb5pvCC52gsFGMkZG3P4/qUzvWMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH5exfM9TZrPfCbi8UG+36JPWyZx0OYahac65vuenwGgt7s4by8z1OebR3TGTijEB38+W7brHQ/rg3ok2sKT3uqV0CsMEZ3BCR/1O/uCnhOK9TvY6ChPPcTgm4HtQLDrN/AdMjiLRQnS2cw+vrtvheh4cBNlcnKi6alnXd51yDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KVcJLNgj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3687ea0521cso4713766f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723643483; x=1724248283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HY6+pCY9ehqSqJDFE8HV9VdLuiE98nA8v+BgVfOFgHw=;
        b=KVcJLNgj+D4lLHA2hRz2rfNoUmf7OjAdDEeUqEARHziaN3SjDZ+PkSWDCZathESLtF
         cSB82d9+XrbOSXAsOlyOwuAy5w+KINmFQyUINjFdNqXl6xz8wqw2NoplPz2znOfJ3ojx
         arcJtmObjcRnL2KKjCHfT7oW6hQjJC66rquMSQA1wzMtxkMqf8NTyMeNUiMg8zdx/sES
         fQVzBiFGyrVdL1t8JU/VLPLqCcvrlT0sVklVtWzaCFzTxe2HCkOyhdzWjegG9yIcqeYC
         MHZ4xPnDLZmuGxl3eXe1UC4uocBvCySLFrpFZ2xCZK5evrLzNLG5lTO7RhdX4JdAvjix
         Y1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723643483; x=1724248283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY6+pCY9ehqSqJDFE8HV9VdLuiE98nA8v+BgVfOFgHw=;
        b=O9pGRHQvLSKar0vkmoOvTN1K8PRYxPTKOR65qJfAOmOtCW+TByWdujq3F3M5mYpNTq
         AdwiHHxHr5QNx/EL5D/lkrDD9VM3cZUAd1vd3pw60gQdv0I8k73Ma8y4QIqxhgDebPkC
         KUl4JBdcqkb19dhdgkLY3b5KJd92rwfhk3wPKD751lSlmEr1vT1kKJUtX+EPOV0RR+vu
         fGeJHSINytMJiIJLHRCsDCC2a2wblmZrctUy6uNt73YDHZs1MSPPLfmoJiJGpGHZgSeZ
         B7fxLSVEgPqt9gyM7v/h0y7CTZ7b/irFFqgeyPyRcEGKuPIi5cAvXhTg4eAQfAgyUr4I
         2tSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9MajzrbGGfINzMq666CBYoNTfgITkv7gvXSv9pwF+6nVSQekatLxvqqc+MmN0A6YPxhvCGodKizXwDTCsDHG26BeJ0TFm
X-Gm-Message-State: AOJu0YzFhxJhoVrglcpmTsyHcgHdS+Uspb8tzs05hhVJlwDFb6L8NmmB
	ZTeKxM9mxk+XidzAO12ILjDPEu5TcEm+qacMGv0xFfDUJ8EWVFZBG6+eDS3MBaeJz+hUxn/Qv66
	6
X-Google-Smtp-Source: AGHT+IGM/Kg8J/CcdohjEY5RAm1+8y6SdzbAu07J03j+lQEZzw0NedV1E9ohGzx8kXDzo6AVkCvs3Q==
X-Received: by 2002:a05:6000:2ac:b0:360:75b1:77fb with SMTP id ffacd0b85a97d-37177742ccamr3008355f8f.8.1723643482955;
        Wed, 14 Aug 2024 06:51:22 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c93714asm12856184f8f.27.2024.08.14.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:51:22 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:51:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	wojciech.drewek@intel.com
Subject: Re: [iwl-next v1] ice: use internal pf id instead of function number
Message-ID: <Zry2WL9JFtz4Q-N1@nanopsycho.orion>
References: <20240813071610.52295-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813071610.52295-1-michal.swiatkowski@linux.intel.com>

Tue, Aug 13, 2024 at 09:16:10AM CEST, michal.swiatkowski@linux.intel.com wrote:
>Use always the same pf id in devlink port number. When doing
>pass-through the PF to VM bus info func number can be any value.

From the patch subject I'm not sure which tree you target, but since
this is a bugfix of something not recent, you should target -net.
Also, please provide "Fixes" tag blaming the commit(s) that introduced
the issue.


>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index 4abdc40d345e..1fe441bfa0ca 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -340,7 +340,7 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
> 		return -EIO;
> 
> 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
>-	attrs.phys.port_number = pf->hw.bus.func;
>+	attrs.phys.port_number = pf->hw.pf_id;
> 
> 	/* As FW supports only port split options for whole device,
> 	 * set port split options only for first PF.
>@@ -458,7 +458,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 		return -EINVAL;
> 
> 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
>-	attrs.pci_vf.pf = pf->hw.bus.func;
>+	attrs.pci_vf.pf = pf->hw.pf_id;
> 	attrs.pci_vf.vf = vf->vf_id;
> 
> 	ice_devlink_set_switch_id(pf, &attrs.switch_id);
>-- 
>2.42.0
>

