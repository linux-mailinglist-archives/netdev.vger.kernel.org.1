Return-Path: <netdev+bounces-96294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375908C4D7F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBF8B20DC4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9B17996;
	Tue, 14 May 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i52Wfsb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE810949
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674185; cv=none; b=iwoB/4+YK+c0sACuFvjN+GzLQav0JGBQ7BAwWXDSQKzALKtcRVrJFQtZzImR1i+f9BQjWgCGexGo42Rqh7qazhCh4Gz9PWYT3QSpqkT8yjHN/ewgw/5X6HKlWhGrBAThyr2r2I1z8G9bSQ4x1ZwLwiltZyfFYuTKq8U1Td3fnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674185; c=relaxed/simple;
	bh=1sBweaTfV/AzvWND5q+CJEYFoL8M3KNW6Ic6UUiXQKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTvBUQY8zW3cIATljdz9qz1Jd7PZ0XuyKoqQs0JEoewb4lKLWMRKJgGtpU2zpq6db2Vbunwu7pt5+Esn+RKuhFj7C9JG5bKfih2jYIk2XpQlb+LJRZ+mkK8czEsaFzcd6lssTXUPT0uSjoDFuxh6cM3cBhdC+1ZaDc4YLJLd6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i52Wfsb8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42011507a57so18965855e9.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715674180; x=1716278980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4eXfZhzqpqMxxqMfSDt/iMj3dyX/0STQtNt3Xv738Y4=;
        b=i52Wfsb8qGzlGpCx/6rnm0MBEL1Ng2pfO8udPWUUWsSN5vTZ4t8CkII3tNWmiqptRM
         d8U1z32ksl0h4aXX4hBqC3P3qa8wGfl0qnA/uT95+f3WhafdP5QXA6LhW4wsesR6WC1q
         X9rMax/EzoGeVTAzQKBrXFe86PZzw6YF9Zm/fV6qhXwDysjOeAq7Hrk2hIrEFBESGPPs
         /OIdrlvPebillsi5d8i7LoBeoFX5pI7fj9nZmQYhjUEjoMr7TplLCPYwKWgdBUu3IWzK
         DAfBIPt4ZIB1VcGW0hoXum21P8K51D6MqnkI47K7r4zi8H/PO9N8AJYCbZZ9USHfK6Tn
         2p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715674180; x=1716278980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eXfZhzqpqMxxqMfSDt/iMj3dyX/0STQtNt3Xv738Y4=;
        b=iLt7B6GDD+CoE0kcjdqKa+18sWBRUWxgTOz/lQJDyo8Pv9cBZNclX40mPDc0DmnMEf
         Dyh1Be1h9fd9u3Xfm98LaJyu7rV4SfSuR1Xyn0+oqtzdKJcnEoVBVinhW1RYG4sKnmS/
         yoDhYvIZzDw5DpeIUJe7qb7FKuOg9jYxYo9lEeCKaHkplAlmUVYg3aulxZ5epySXcEnf
         kdxU27RbwhuQYvQurQUypILHbwD5nDd9Ib9qO5HzHHQYN6J8xHxefyQu8Y/ujH9k9PPJ
         NjDEwE5nN6GtKi1RCyUR9at8t08Ohr+XaERvGzFLiyOQctoINY+JKtMkhdBUV66RL5zr
         WgnA==
X-Forwarded-Encrypted: i=1; AJvYcCUf06wi7LBq7ZSWNbQ8SzxN1a5JiD2FCRbNOQpJetQx+dds/f93KEYHjewrk87mCtJOAtk4PaYC/hdn+iupnLXGE06sAT2s
X-Gm-Message-State: AOJu0YyLjfYb0LFqsTJ1r3QeVoojW6Nx+nOB4IjQSUiE7/GvCAOLjxys
	ci1H0Eop63Y6K0AlyuRSFhRkgQuxHfVJ7++QwsaBzFn0uJkCx2zUi1wUFCh1G24=
X-Google-Smtp-Source: AGHT+IEKybC29u5QFqLb0noL3UM0DJR98zKLIls5EVTQA+hArm3Tc/2NQxav9keJQlFXSA7NuiIfNg==
X-Received: by 2002:a05:600c:a04:b0:41b:ca45:8263 with SMTP id 5b1f17b1804b1-41fea93a609mr96726025e9.12.1715674180328;
        Tue, 14 May 2024 01:09:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420149b1c24sm73755965e9.41.2024.05.14.01.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 01:09:39 -0700 (PDT)
Date: Tue, 14 May 2024 10:09:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 03/15] ice: add basic devlink subfunctions support
Message-ID: <ZkMcQII3AlfMu2Yl@nanopsycho.orion>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
 <ZkHztwMeJFU73WQm@nanopsycho.orion>
 <ZkH9DurNJ/OFDvT/@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkH9DurNJ/OFDvT/@mev-dev>

Mon, May 13, 2024 at 01:44:14PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Mon, May 13, 2024 at 01:04:23PM +0200, Jiri Pirko wrote:
>> Mon, May 13, 2024 at 10:37:23AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> 
>> [...]
>> 
>> 
>> 
>> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>> >+{
>> >+	struct devlink_port_attrs attrs = {};
>> >+	struct devlink_port *devlink_port;
>> >+	struct devlink *devlink;
>> >+	struct ice_vsi *vsi;
>> >+	struct device *dev;
>> >+	struct ice_pf *pf;
>> >+	int err;
>> >+
>> >+	vsi = dyn_port->vsi;
>> >+	pf = dyn_port->pf;
>> >+	dev = ice_pf_to_dev(pf);
>> >+
>> >+	devlink_port = &dyn_port->devlink_port;
>> >+
>> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>> >+	attrs.pci_sf.pf = pf->hw.bus.func;
>> >+	attrs.pci_sf.sf = dyn_port->sfnum;
>> >+
>> >+	devlink_port_attrs_set(devlink_port, &attrs);
>> >+	devlink = priv_to_devlink(pf);
>> >+
>> >+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>> >+					  &ice_devlink_port_sf_ops);
>> >+	if (err) {
>> >+		dev_err(dev, "Failed to create devlink port for Subfunction %d",
>> >+			vsi->idx);
>> 
>> Either use extack or avoid this error message entirely. Could you please
>> double you don't write dmesg error messages in case you have extack
>> available in the rest of this patchset?
>> 
>> 
>
>Sure, I can avoid, as this is called from port representor creeation
>function. I don't want to pass extack there (code is generic for VF and
>SF, and VF call doesn't have extack).
>
>We have this pattern in few place in code (using dev_err even extack can
>be passed). Is it recommended to pass extact to all functions
>which probably want to write some message in case of error (assuming the
>call context has the extack)? 

Always.

>
>> >+		return err;
>> >+	}
>> >+
>> >+	return 0;
>> >+}
>> >+
>> 
>> [...]

