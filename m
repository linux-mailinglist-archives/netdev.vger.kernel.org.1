Return-Path: <netdev+bounces-223631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F0B59C25
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26975323FA3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19A3680A3;
	Tue, 16 Sep 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="i5AvMvk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43F368090
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036868; cv=none; b=PpjNXGsQKomNRWQfeq1KSKqDvT7VDb6JELIiNLnw7rJsIkK5m07s5mR2ywmZJS6jnFD1XvEDA95P58fwwdGtNmn3z8ilkEL4CeWus9vfw+NRBueXT2S5S2IIHNUXhnXHmJCXA9MYeEyxpgdrDV3D+0TFTUK9PEvQUvezr2DnK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036868; c=relaxed/simple;
	bh=xTMQRJoceVtSoCBzUKkh2X2of9MTcPclXEdl1xxpk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anW1SvfM859RtWxCu4IagGob6CCc9WtQYJaLDOTjVysdf6l3QAZkNx+iUAjHoNMO5+iIXpa56zBBT78qFoO1GkRxEdAsU9pPrtRbVToygrqO1ajX/iPcDe4wOjpHV6KoxCbRj2wFPbiuqk6QdPYBOO4B6OhMeiAh5pA9UMuAZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=i5AvMvk1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso5861414a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758036865; x=1758641665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3t3DZ67BSYJLuDmPpEbVIG9ODRl+f4GpJwYespPfic=;
        b=i5AvMvk12BsjFlf8xlYRGsyQ/ThytgxT8xeXSa72hn3VkfTszy92fWLNRb1dq6iq78
         1I5ENjsJ02UIYi/cyB42V11wv1MtIXJKvUq6UfJ0Lz9rC+/lrNqdVsZ1+3eRQ9jmfmQr
         JZP7MGhdbuuCXfVogyYJMZSM/t9QLHXRkauyp0P0cRHmxiI895n0IdYo8GA19f69jBE0
         urs2JPpmcqmltjmRayGpZbxv06s0I/e0zXULy1KAjx/SxdoCISy3lmvKGqHpBDGb+siU
         NmzM0Z5FXHhCizm5IqgWJBAVS4KldqHWycITD6LbuYiMQtkVo5zn5lxMEG7jmXcApVzr
         ddvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036865; x=1758641665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3t3DZ67BSYJLuDmPpEbVIG9ODRl+f4GpJwYespPfic=;
        b=XZEeTwuG62KKQBvVVeouA9sVkvHbeHY1nVYGU4w/NvvN49V8y3HA7cMNW9umZeAe9X
         NYcXlpo0u5Wt5uEtkKE2j2Gk9bTaqtNtWbcQPCXVDfUZnOyWX77E7MCJHu1Dd1UyjxSg
         3jtYFChkkEninLpYF+Bz7AZH9TdpxhhCgSNCxALZ8sR9iwtD1R3Gw4z8cQ72g81hddhl
         teivxJFjhTvx3rpLDzrysUa7LGPIDDTr7kxwabjWIO7TX22WjbSXeSPkVPbT8bTV7Dkp
         2Lr3udIjMllbBm8SjXl7h6sPFCzhVprojlZ0hS3xiwkBiOQnGOjGbxiPs2HJ+YYwb9Rb
         1j3w==
X-Gm-Message-State: AOJu0Yy3Wxz0XR599ZTIQT+M+/KdKC/PehXO7ROWM9A2yTfnYx9sglkT
	SgpJo82hSSpgrGsi/wA1u/IYyOSuYK08coZUAL5IxHdPcWQv79s0iZKaLGupqrRZcU0=
X-Gm-Gg: ASbGncuafbh9F/Pa8akDE4LLxy9t993j7qYsLPsY3ZfQYEtZKRlwWPjDucaSy/J3SfE
	+dAopvGNuCJPU/dE1sResI8edgmZ84sgLPlJlrF0tssQVv44oEtvm/txfN62/jXpvcpVjO3A2Lr
	pylxnSKIBcs60dKcpeZPVbE7I1TtAG59rD4OQieYrNHPSisHP6TA4gDnTxzH1SgRG+CMaY8+MWw
	tIQHU+ngTDifz7JDrdcBaRp+fy062CZMYuGAbdQUY7tuOknm7vV0YxzCHvlhNNQIse70L4bPvq+
	k9+LbBO/fTpLKhfUCnfixn0GpKxq/nBRD63hZAeCfsEH5XeVssqWyK+NllJIEYrg/Ej0GCrmVdk
	/O4cpQuIbkBxYLzkJ6sD4tXbSFZo9d8yl7tIEDPhkPxGJR0UKETJ8vCWULVo8aLHijH/b1wnGxh
	rb6jQTMqZfpw==
X-Google-Smtp-Source: AGHT+IH46l7dhoz8C99BB9IqLyGqt0Rac/meRbGkjiHfdiBZ+iZH8bXeFNi5DAO5zYdkNmBfn7xVBA==
X-Received: by 2002:a17:907:1c1d:b0:b04:a1a4:4bec with SMTP id a640c23a62f3a-b07c3a67aa8mr1756834966b.58.1758036864619;
        Tue, 16 Sep 2025 08:34:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334eb65sm1179437066b.97.2025.09.16.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:34:24 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:34:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v5 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
Message-ID: <20250916083418.7e94a93d@hermes.local>
In-Reply-To: <20250902211705.2335007-2-wilder@us.ibm.com>
References: <20250902211705.2335007-1-wilder@us.ibm.com>
	<20250902211705.2335007-2-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 14:15:52 -0700
David Wilder <wilder@us.ibm.com> wrote:

> +			if (RTA_PAYLOAD(iptb[i]) > sizeof(data.addr)) {
> +				num = num + snprintf(&pbuf[num], size - num, "[");
> +
> +				for (level = 0;
> +				     data.vlans[level].vlan_proto != BOND_VLAN_PROTO_NONE;
> +				     level++) {
> +
> +					if (level > BOND_MAX_VLAN_TAGS) {
> +						fprintf(stderr,
> +							"Internal Error: too many vlan tags.\n");
> +						exit(1);
> +					}
> +
> +					if (level != 0)
> +						num = num + snprintf(&pbuf[num], size - num, "/");
> +
> +					num = num + snprintf(&pbuf[num], size - num,
> +							     "%u", data.vlans[level].vlan_id);
> +				}
> +
> +				num = num - snprintf(&pbuf[num], size - num, "]");
> +
> +			}
> +
> +			print_color_string(PRINT_ANY, COLOR_INET, NULL, "%s", pbuf);

This code will display multiple IP's as bracketed text if using JSON.
The more standard way of handling this in JSON would be to use an array.
Could you please rework the display logic to do that.

