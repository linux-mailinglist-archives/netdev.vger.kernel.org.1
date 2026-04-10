Return-Path: <netdev+bounces-277202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c7r5N8FZ2GmWcQgAu9opvQ
	(envelope-from <netdev+bounces-277202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:00:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5B3D1439
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C748C3008A71
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F002C21DD;
	Fri, 10 Apr 2026 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFrHsGoe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7A1B85F8
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786429; cv=none; b=gfeinIGMIea0XOFFTxgESqUssZkV0jWEZ1Z3o7zf6Q8iAiKT+oNY4EU3e3nOHfznV4IrVg83WwN2q2OAqbS9+/+ElAMvfYzL8+YVbzY/5DKQgNUP5LHY3QkF4c1PWetkY/efltmSnYUEYyvYb+0F1DvRoA3FfxEnG93lTpJcUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786429; c=relaxed/simple;
	bh=q02+w6fVA8fQlZiZYJsvbUg0TeTNTZ6gfTuEjCsRLwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP7kEHD1g7tUYn1gwaAhy6XE4MpY8fobv1j/oXWOUQ0usDLQHWCTFxnL5Aj+/+S6un+9T/BrilqaBnQxsLg7KLdQt1BnGHWs1N/wTubZMOeKV90cPEsFESNVlLbjz7sqZgngrkQjGp1K0U82qFyas0iA8GnMiYgPY6V6krh+ajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFrHsGoe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso15834215e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775786426; x=1776391226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bovVPq2Hy5sXrftDQTh1EgPcGL6nK3K2wa+9gcYZYpk=;
        b=DFrHsGoeJ7v3oOgSESVXgmFw3Q3zutj6GNKIhH7QVYHEoLXTYVPZ5s6H4JmY2Wq9yd
         A3XnNnU2emGpnWS3YN0bMALoxg0QB44i65z/oKdVfnesdKEfUD+EwbwWL8InRNhOjnKm
         nTbAQw9idBi/O9/XvBFRrkO/yyicr86WAKDjY7x8qIwZiHPv6UkNXATk6wg6yNyTtDvp
         umUJ0QUFHfemH8c76kYWc0CMRBCDg711xRRR3rwbPg9ujU9pWG1c6PWnMPKhzJEehQNL
         oAleuVlKwILMoOVHtMDfC8ygN2ANgGOiJKU+LDU8r77gtbJEFUo0G4axsSwJOI/r1Z/8
         CAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775786426; x=1776391226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bovVPq2Hy5sXrftDQTh1EgPcGL6nK3K2wa+9gcYZYpk=;
        b=cfX72KisPfX4O2k2bhRt3Jo7XhVRvTAayHd6e7+MXDh1MGdaoECsMEdo5Vqdy1qmmw
         nFwuD5Bx4U50wC/EdcA/fy0bdw4m/qz/IucC811mujp2B5Z03Q3NMy8Rq3XVvENVmL4p
         D05jhWDXKTyMwM2Q6ifh1WpFndviDw1Ca/pbCuODVGBOkPjssrKK9mKOvJDgwcsvVoo9
         Q6G1BZSIf2DMNcGxLY1Ls7OSguDfHBj+rES13Ry58eQhgnpnIfRf5juViWbZGdGTiJr0
         oTXo2izQsyS5zUfmJkDPjBOyvhnkpY7omiwNkQH7HECP168jnHnkIIFmwS+TzrEdDUNp
         o5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUKZsU+v+YHP890c0CEXgmqnH9VgSGfnPrmfNShoA49n1WX5xCVGzq4euDEs0Df1yCpPWLAnyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyIClp4zBm+gL7udiYHGoZ/wLCH12wcmniTC5sgqyJY5F9QGo
	XVAgFZES9wJADmstrTyJw+eRa0XAxSTN4+BuAdzLPH66V2SX2D5dGDp9
X-Gm-Gg: AeBDietIa3NzQHCBNZdOV0W3Kx1Ac1rzRdxzl8dkZbwFH21uhm3N6ReAfPaMZVdfxp+
	lk19l01pcjPdpRlRYD+bHdi43pWRtVC5E3VlmJdmXcq1J0JxxXiyD6/YzPhAMRuEHhlxHbEWmje
	X0bo2s+tP/zCZHRXdUZPWM21ZuGqy0cvsraXONFY8kHsWvZHIi7SV5mR0jQlQ03IoV1elCj8pNw
	LZWU6MbV4/JjZXagYE1PLrMcs47npf0NL3lk0TJ29ocL0tTZy7CVYESJFlbXnM++B/oA5OIV1oj
	U/q/wKmiWHBy1T0AkaK47NV278BpcwpLyY74+LMiXetKokMwPoSCsZOAOFONHeoKr1e5rzLtQ6j
	YjqMVjI2zOJSlQEhjF8XzkDyigRODrqvbZJTkMVkwStyM5+9KEZbggOji1jP1+3ioqeGZbyj8JW
	XMvJemtDFcM5lriUdnbfnniw3linSA0VwswCEssd7F89nOfDzIVCukB0H+96QQDwhknmD3cwwwv
	+VVcoe96nCKoRQyV7+xAXyEoYEMtApXgn2tAHDVerqzLEob
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488d67f39admr9380185e9.11.1775786426068;
        Thu, 09 Apr 2026 19:00:26 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d703c1sm9427005e9.3.2026.04.09.19.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 19:00:25 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: cjubran@nvidia.com
Cc: leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	prathameshdeshpande7@gmail.com,
	richardcochran@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v2] net/mlx5: Fix OOB access and stack information leak in
Date: Fri, 10 Apr 2026 03:00:25 +0100
Message-ID: <20260410020025.7386-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3a238d0c-4ec1-432d-995a-19d7db3e310e@nvidia.com>
References: <3a238d0c-4ec1-432d-995a-19d7db3e310e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-277202-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32D5B3D1439
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 17:16 +0300, Carolina Jubran wrote:
> pin is defined as u8 in struct mlx5_eqe_pps, so pin < 0 is dead code.
> 
> As for the upper bound: in order to receive a PPS event on a pin, the 
> user must first configure it via mlx5_ptp_enable, which already 
> validates the index (rq->extts.index >= clock->ptp_info.n_pins returns 
> -EINVAL) and since the mtpps register only defines capabilities for 8 
> pins, so n_pins cannot exceed MAX_PIN_NUM.
> 
> Maybe wrap it with WARN_ON_ONCE instead of silently returning, so if 
> future hardware adds support for more pins we would notice rather than 
> silently dropping events.

Hi Carolina,

Thanks for the feedback. I've removed the redundant pin < 0 check and 
implemented the WARN_ON_ONCE for the upper bound as suggested.

I just submitted a v3 as a fresh thread with these changes and a fix 
for the union corruption bug.

Thanks,
Prathamesh


