Return-Path: <netdev+bounces-180326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A36FA80FA0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA08169F2D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23281221DA2;
	Tue,  8 Apr 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LrDSWY1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6F757EA
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125283; cv=none; b=GHZ4ik8KMQ6q4/LDGvo0G3IzSEfGamiWhzwx9zlN8bw/dfaZ4MzcqyRTlE2f3S7KWUPrxNXcwx20fVPGYJAunawjDE6l2m7CldmvibYC1GHGA8C2x3pH97n40nJ8EQblJymgSYRK8p5YfH1d12F8d7IyRd+ApFGnh8IHxWlANkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125283; c=relaxed/simple;
	bh=SPSH2WSE+XljXvfZIgoqUM5llE/o4vKzaxbeTFlVrks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=GSJ/NHmxxWRH4Wf7gD2ZDUiL5bmfmZFXCz9jiCRzwrK2P2lKNxeKYpeLJBY8MppddxHDZIUtOMiid6d42nrwOkAHE5lvgex8MjL3Eqct1W3N+xUvLDLCAFtdoyvxq8X004YPeLu/CyXqN2ealBSRWpgFxTTtYMWcibIa9t+6UJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=LrDSWY1f; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso44320455ab.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 08:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125280; x=1744730080;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/O97uOoVzQU5zZ/kGe0w5BAxKzZ3HHF/MfBYDQo+ew=;
        b=sRcPDHCvDBDfWY4/g75B1VBLoRTzRPvSooigofQPZ1Rx8V+azHsleXnYsbrzwDdo79
         6bNMHO1kMIvoNI0FFpcgaKU8+P4Rb9gVKt2uzVzBzQ7J6o4+Kq1vEJhExDp+RMS3A75Q
         0Bb/kVLPCqWm1wTpGcRskPejIxCXJ69KZ3ycKJCANfF5UCI28jNXWjkr1laGWzzR/neM
         YSkn1zfgz8N2UPXOmplEzwlRR23AtrFNEID2lFF9O0XyMJab4dHxhtkD374SBHc4nT3R
         /97eA4mLdkqZ+x+rakQKTmkzgE9U9YoeE3NhVQbRC7dawf4/62E8y4IHOAuCz09vmeMd
         3NMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDZZS8hXymnOvp0o2wtkhY8AFWfXm0aZxWx95jQuR/19kEhwI/b5M7uE1jIoI6lzgmQmrlWMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrkSNMIo2O56n6hyp/aYQpLhdebTYky8rODaS0hfG8I1nkrMl
	7dtawvNoB2uVFtWtnG/MdF7C5axBRZ2Zl/BMU4+H4XxV/8m28UwDWUtyjMyqTgwTyqB8rocAZJi
	+c7BjG4Hejqlg4/uv2GRLyX3oaF6zeg==
X-Gm-Gg: ASbGncsm6F52YCJCaCBP0HGwOiR/2FRXSl+SsXkdTpZkezv5bXcJCBcYEquwm9hVxDx
	Ne41/TV2psq+EURtDI7WqtH82B7qbMRU+CYgY2pKMLOzB1kFSbo4ySt98XoEX0CiLchYAEW2ARu
	s1tKapituGu43qQxUximJQYpdydieC+8jX8HqbfqsfaOsf9H1tjQwmNKrfuVf2oWC6q5qPq6+wY
	LW1PV2D28vmrKYwb33NKHQwEZAGng5v6+q7HMf8YF+c7Sh9dudwTFJA2g6HH1TZJHpvr5O2LTOM
	BAJPZ4l8HUYZhJUJ9BRZWySf29Q=
X-Google-Smtp-Source: AGHT+IHRBTG6+uqcyAAc/HKIV+mc/d+bQv8wck3AXmAPQOGb3TE7JsAnfu9/DW9a3DfSEJWosmHZ7CG1JJKH
X-Received: by 2002:a05:6e02:348f:b0:3d5:df21:8481 with SMTP id e9e14a558f8ab-3d6e3e66be1mr184350015ab.0.1744125280423;
        Tue, 08 Apr 2025 08:14:40 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f4f43bb938sm120574173.3.2025.04.08.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:14:40 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744125279;
	bh=R/O97uOoVzQU5zZ/kGe0w5BAxKzZ3HHF/MfBYDQo+ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrDSWY1faZQQFl9QwD7/kcPM83WYFdTHMX5npzlW1T1CrRpVsZKaNI6dYqh9dIkuc
	 si5P4JoOCqnH5/O+d4FV6NbxTUaZ7GVJijv9lzdewWh5qRutHupZZAT4mCbRY4gTUm
	 EHsaNZ4A9FA1DG4VVOhFkiDXlqJkBvh/9TY61WNOhhuwZ1ueWHNZSJxmCBokFEBr5c
	 W+jRD7fHdR/GT1UqTvM7UAtO/dvZZs+rNI/1H46tQjDV+f470+xFjoEqZjbXhSdMGQ
	 UO88GEFnoKEATLyKVKrsnR/JVwEtsaj/OGnjOVYkvIDAnkF8zLOsxPzgv90IKl8qd0
	 cIXrdxGhPM3pg==
Received: from mpazdan-home-zvfkk.localdomain (abran-ibgpevpn-us285.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 9F23B10023B;
	Tue,  8 Apr 2025 15:14:39 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id 9864340B19; Tue,  8 Apr 2025 15:14:39 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: andrew@lunn.ch
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	ecree.xilinx@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jianbol@nvidia.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mpazdan@arista.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	willemb@google.com
Subject: Re: [Intel-wired-lan] [PATCH 2/2] ice: add qsfp transceiver reset and presence pin control
Date: Tue,  8 Apr 2025 14:22:43 +0000
Message-ID: <20250408151439.29489-1-mpazdan@arista.com>
In-Reply-To: <6ad4b88c-4d08-4a77-baac-fdc0e2564d5b@lunn.ch>
References: <6ad4b88c-4d08-4a77-baac-fdc0e2564d5b@lunn.ch>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 7 Apr 2025 22:30:54 +0200 Andrew Lunn wrote:

> As the name get/set-phy-tunable suggests, these are for PHY
> properties, like downshift, fast link down, energy detected power
> down.
> 
> What PHY are you using here?

Thanks for review.
It's PHY E810-C in this case. According to spreadsheet: E810_Datasheet_Rev2.4.pdf
(Chapter 17.3.3 E810 SDP[0:7] (GPIO) Connection), it's SDP0 and SDP2 GPIOs 
are being connected to QSFP Reset and Presence pins correspondingly.
I assume you may suggest this use case is not directly PHY related. In first approach
I tried to use reset operation which has following flag in enum ethtool_reset_flags:
ETH_RESET_PHY           = 1 << 6,       /* Transceiver/PHY */
but this doesn't allow for reset asserting and later deasserting so I took 'get/set-phy-tunable'.

