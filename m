Return-Path: <netdev+bounces-115350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE6945ED8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF54E1C218C6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16E1E4852;
	Fri,  2 Aug 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Iw5Will9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E11E3CA2
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606273; cv=none; b=mEJco0ZE+Pfbx91CcU9jR4i+/2j1ZdTHlgm84HvSJZeD9S24klEgYAB4hRGn81fIjqDuPLACZ9sGZelLvVdpa51p+0cSMwPEryJOA/ZOxQhIl69HA4fk5bL338MPLz0Y7ef1o05xnKpaaKWZm2uqOVCuaQ5wIRYL6oxpBE/DoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606273; c=relaxed/simple;
	bh=1efkWGiDHWHdjxitvJU2lOsyO5FMDJ2UXUZfBLV1rPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF6pBJzcS2GKADzF7ec2XqC2j8AULCo7DLuL45Ra+0fyHy/Luv3XuCGK20CiiZXcPtebYnMBWd01JrCjlGyJ+BP69yPogoEzzP+opRGDIJZN2DJXIBFu27sY1Gh1SNunJyhw26AMNuGULIwCh5yin3Rvy+y+aMM5iVSAd5m2pU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Iw5Will9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso54701485e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722606268; x=1723211068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bR/BoKOvJjncPDkwbIwKNrI1z1C3Y+TBt30sW860pJw=;
        b=Iw5Will9Zw1XNPh1HLAb3jZZI6uc+e/E4Okg/yIdU369mi4QNTqYWfdeAK/AphSL7t
         /PJoKuIHrrlXJnEt+ml7XXizCGYkdPRmONUY5nM3oOjo8M0aoLqucAKo4d35ctj02lk7
         ZkCljnXIqXiBnY9nDerIk1Cdfio1OiFSKmf1I63cchwi403+nF9zyQ+ZxUQoq4T0THK2
         j3A+rkbDhEkMnlQKG7YUGgQkFOOS5GRhqsBa+2Oewl/iXu31uykyEq8KoVzXy5MIqQIW
         w6SRp+byJI9MIh7InQDq0YJHux8+WmUZbKVU4EuzAq1TPsla05LnoE+auateENEV+vak
         2OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606268; x=1723211068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR/BoKOvJjncPDkwbIwKNrI1z1C3Y+TBt30sW860pJw=;
        b=RRDM7FnRV+SK+wz3kAtl6MYdmSZzIcfaxL1+kZfmHhr1huZy2GQflLl7m29G1xIBaj
         g9acg36A1dYj14Xip58fed1QYCCRO1vaNV2RzQVYO6x07hhVgG/+Ty9cW4Lb2xP1gwe5
         2ZW2+p2HqnLDRJM5KHfppVPv8ZqZ5PV8GYV+Iqo0MvrrPKB84i79s2LkbJWizKY+Qhem
         gHr8v4BcN4YfopfJ6rGCQb5buJnqbJ/7XYViXEbPPskol0wm8aF2xFNhxsxog2wL5YOd
         pxpIW0ibPXnYaU90/ANQpP6CY9T+EbYF6jqxX2e0LL9I8Oa+z5vcynjW7Hms9PhdN3+V
         +zgw==
X-Gm-Message-State: AOJu0Ywja6BUGQCEun3z12YyvUf3wOPEZ1Cd1IlKxwke52dm+ee8h44O
	ygdoz9ti2gYrtbJ3Bb0D3AoMLutt5Vrc556eOHz9M/7//WCjmBNPJH2wxX71/74=
X-Google-Smtp-Source: AGHT+IHwe25Yzh1zgKM10nuGReAx/m3GzUg6GmXZxa66/Hij1EzsQNz0fIvuFPxle4f8BnurKV4xIA==
X-Received: by 2002:a05:600c:19cd:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-428e6b090d4mr21541365e9.16.1722606268163;
        Fri, 02 Aug 2024 06:44:28 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm28239765e9.47.2024.08.02.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:44:27 -0700 (PDT)
Date: Fri, 2 Aug 2024 15:44:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH RFC v2 10/11] iavf: Add net_shaper_ops support
Message-ID: <Zqziup5Ele_jBm3M@nanopsycho.orion>
References: <cover.1721851988.git.pabeni@redhat.com>
 <403db492c2994a749d287e37a7c32f3d0ebfa60c.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403db492c2994a749d287e37a7c32f3d0ebfa60c.1721851988.git.pabeni@redhat.com>

Wed, Jul 24, 2024 at 10:24:56PM CEST, pabeni@redhat.com wrote:
>From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

[...]


>+static int
>+iavf_shaper_set(struct net_device *dev,
>+		const struct net_shaper_info *shaper,
>+		struct netlink_ext_ack *extack)
>+{
>+	struct iavf_adapter *adapter = netdev_priv(dev);
>+	bool need_cfg_update = false;
>+	enum net_shaper_scope scope;
>+	int id, ret = 0;
>+
>+	ret = iavf_verify_shaper_info(dev, shaper, extack);
>+	if (ret)
>+		return ret;
>+
>+	scope = net_shaper_handle_scope(shaper->handle);
>+	id = net_shaper_handle_id(shaper->handle);
>+
>+	if (scope == NET_SHAPER_SCOPE_QUEUE) {
>+		struct iavf_ring *tx_ring = &adapter->tx_rings[id];
>+
>+		tx_ring->q_shaper.bw_min = div_u64(shaper->bw_min, 1000);
>+		tx_ring->q_shaper.bw_max = div_u64(shaper->bw_max, 1000);

Isn't this more or less what ndo_set_tx_maxrate() does? I mean, the only
difference I see is ability to set min/max. Do I read this correctly?

If yes, could we have the ndo_set_tx_maxrate() consolidation included in
this patchset (or at least to post follow-up RFC)? I mean, without that,
there are 2 uapis to set queue rate limit for different drivers
(net-shaper for iavf, sysfs tx_maxrate for the rest), which looks messy.


>+		tx_ring->q_shaper_update = true;
>+		need_cfg_update = true;
>+	}
>+
>+	if (need_cfg_update)
>+		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW;
>+
>+	return 0;
>+}

[...]


