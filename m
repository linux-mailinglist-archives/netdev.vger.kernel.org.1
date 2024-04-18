Return-Path: <netdev+bounces-89202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CE8A9ACC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884E1281D23
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE98BFA;
	Thu, 18 Apr 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TE/Cg4L8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D312F379
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445353; cv=none; b=WfeBdj2ePBmSj5mi/EGiQupYzSmFuNEh/Xnw+nSqY6r2cry674i1ss7i4chuOQsUQiOkfzEeaeVO8vvMdMarioBl28D+ffRZ2qWJNx9JWkVhaLN7E6wSQzM9p5RfnFGhU/PgHYacHzbG8GKldQy4kTr8NXy4Eb9lfN+V2P6gbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445353; c=relaxed/simple;
	bh=5OMP7MjSmX2lFnzHlVvUnOXWhZ9hLW8Cw7igkhXBWPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY0Vo+RucYME1MlS4KXD+hgsnMGO6nwy+WrMYApYVqoBNT2zwFVVpJLfrxZ44PVFFy51g2HLxB40uhfqW6IZuvsJy152ngMf9f1pbt8yLHnPfW3v4nvRojtTl/6YMjaz9mUOFWb7nqPvmkbTVNVq41rlWcX1sgVvuVfGnISXbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TE/Cg4L8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418a02562b3so6907305e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713445346; x=1714050146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSEbkJW70zZ5sfWUXf2fhvkwK3iAvAImkQZWLi4d0MA=;
        b=TE/Cg4L8t2ddBAwQB7fPhIbsw5c41kFNHycnWe2ty5CmtY/Ua15b3KCmQAuo5xOJz8
         pd3948uKspeaEJNXXtVMcLAzO0ysPltybk4HsUkBHn7aldFVNmnQUlb/7b6glk+QgL1o
         4WRjX7dyGMbY48YveKoKu7fRPt5+0rsbksBV/U2GU8DVZppI25/McrKLPxaNsxsqTNeX
         xbx8N2PZjmPQ9tjBRyE+ZfU3DtlAoWCJX2rz4YONqGzx630g4mylbxvDcnUE6e4ldc+o
         To/+4BrP0BUTTcziNa73j8T8vnB1GS0Rm1xrCFLzeheuE2BtwDXTCw2KzqRfF9dPN3Kq
         OsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445346; x=1714050146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSEbkJW70zZ5sfWUXf2fhvkwK3iAvAImkQZWLi4d0MA=;
        b=ESVsbi1ss4vIEWabSVz6gMFWp8T3p9voFdJwOJowrbi5YZzKQD+laXm4sRjUT9353O
         axyMx/IVztO3AoQL4JoaJ2tLvn+h/17hbUCZ5UHptqa+F6JrGTQIKjFcDTLafFN+aemm
         W5jtNMKj8faNnCypMAo21hgOpnnPiofvRVxU58UYB2Q7c/fDxzLNyhYVqPzQfDLYb2oy
         6d3Xolz1mX5k2jfswPkcdPWbzX6T7niJrsBBOjlfVB6mmVx3Rb/XhiZAierFQkiqYtU7
         q2YERXhYAl0JZPX+QzaZOfXbD6PKCR1CR2sCvihTKlrG4y9N0Ag5lEa+66Z20FPcvO6K
         8iQg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4vdvh54o8vnMNcHFZv0AeH+SWnucR3i8NkdKjsWd3JoXgrbKtlpAbrKZRE2iGZQlOYtlNqJbwJ70znr0nmjUEWGhARK/
X-Gm-Message-State: AOJu0YxiVCfZzBHgKRId6SrmNP2HywxidaU8X7TyMiElOLk2B+ORTqT5
	6QsP+dSohsavppMMcueNn7+SQxPV979Fz0T5iXpknAJfmXDIHjgL/8VYdaFHCXA=
X-Google-Smtp-Source: AGHT+IEfMG36kM24Iof7e34MrpQEhFq9W2iWI9PjZtvx7h35noSdT2wLL+gDJZ9fjBh5ZhYFG0//zg==
X-Received: by 2002:a5d:558e:0:b0:33e:5fb4:49d1 with SMTP id i14-20020a5d558e000000b0033e5fb449d1mr1565460wrv.44.1713445345962;
        Thu, 18 Apr 2024 06:02:25 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b00349ceadededsm1805262wrx.16.2024.04.18.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:02:25 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:02:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 6/8] ice: base subfunction aux driver
Message-ID: <ZiEZ3c-aJ_i6vQ9F@nanopsycho>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-7-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417142028.2171-7-michal.swiatkowski@linux.intel.com>

Wed, Apr 17, 2024 at 04:20:26PM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>

[...]


>+static int ice_sf_dev_probe(struct auxiliary_device *adev,
>+			    const struct auxiliary_device_id *id)
>+{
>+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
>+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
>+	struct ice_vsi_cfg_params params = {};
>+	struct ice_vsi *vsi = dyn_port->vsi;
>+	struct ice_pf *pf = dyn_port->pf;
>+	struct device *dev = &adev->dev;
>+	struct ice_sf_priv *priv;
>+	struct devlink *devlink;
>+	int err;
>+
>+	params.type = ICE_VSI_SF;
>+	params.pi = pf->hw.port_info;
>+	params.flags = ICE_VSI_FLAG_INIT;
>+
>+	priv = ice_allocate_sf(&adev->dev);
>+	if (!priv) {
>+		dev_err(dev, "Subfunction devlink alloc failed");
>+		return -ENOMEM;
>+	}
>+
>+	priv->dev = sf_dev;
>+	sf_dev->priv = priv;
>+	devlink = priv_to_devlink(priv);
>+
>+	devlink_register(devlink);

Do register at the very end. Btw, currently the error path seems to be
broken, leaving devlink instance allocated and registered.


>+	devl_lock(devlink);
>+
>+	err = ice_vsi_cfg(vsi, &params);
>+	if (err) {
>+		dev_err(dev, "Subfunction vsi config failed");
>+		goto err_devlink_unlock;
>+	}
>+
>+	err = ice_devlink_create_sf_dev_port(sf_dev);
>+	if (err) {
>+		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
>+		goto err_vsi_decfg;
>+	}
>+
>+	err = ice_fltr_add_mac_and_broadcast(vsi, vsi->netdev->dev_addr,
>+					     ICE_FWD_TO_VSI);
>+	if (err) {
>+		dev_err(dev, "can't add MAC filters %pM for VSI %d\n",
>+			vsi->netdev->dev_addr, vsi->idx);
>+		goto err_devlink_destroy;
>+	}
>+
>+	ice_napi_add(vsi);
>+	devl_unlock(devlink);
>+
>+	return 0;
>+
>+err_devlink_destroy:
>+	ice_devlink_destroy_sf_dev_port(sf_dev);
>+err_vsi_decfg:
>+	ice_vsi_decfg(vsi);
>+err_devlink_unlock:
>+	devl_unlock(devlink);
>+	return err;

[...]

