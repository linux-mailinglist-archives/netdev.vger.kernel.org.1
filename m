Return-Path: <netdev+bounces-233132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B83C0CC4B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EE43B3D25
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AF2FE584;
	Mon, 27 Oct 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b="rELC9jEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC822FE07F
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558704; cv=none; b=uXNqONdYsGsZXeqaiBS+SOAtv3PuzMeo2az6/wVbFObYta7sUR7MrdbCHn14aOsNFpeVLW4vjfsbSVbUDgZn8mn78jFM7sPG3EQ6CimVV+1O04Goi+hvmKGjHRf6LPItPfhzLNAh9GkkRZceMs1XZ7nSvpSIvCIqTL2cDaf/tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558704; c=relaxed/simple;
	bh=ho8xn5k/6fWo/MTrNIO/VG1OI41Us+9e9ERYp+B3brM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLBJpEdXk7ghLRwrCgtR/gucrMfw0kbOfQwK400sB/N9103clM76h5Pjx/X/z1Ll1DhSCclVxPtnAuL5PYFODPawu3krIGlqWC0+ZTNIL2Txk9IBY6ohsnf12z0PfZPt5kTLypXYqvXz1U/KfEGb2N5+9skRF/kJb72NE9HWsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr; spf=pass smtp.mailfrom=42.fr; dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b=rELC9jEG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=42.fr
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4270a3464caso2074910f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=42.fr; s=gw; t=1761558701; x=1762163501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho8xn5k/6fWo/MTrNIO/VG1OI41Us+9e9ERYp+B3brM=;
        b=rELC9jEG7KjBUI7azR6Cu2uOJaUcWb7iz9nEthoDoAVAxxXGUf4dettBZmUYRF0o7D
         b3K6ZWw0wIXLGCdqFP4w1rd2PKCThb1+rnEwUVO2iIIaUl/fHbDXsq+RWsIs01mXurSR
         2BXnJo42IssiydfJYcKQbWrhtJUf8Eh1+lGCLpNii9DaspRx/UZIePI9zXN1s8D+eyAO
         Zn8iS6OFsK0oZGBl0p2J22beOXhu55g5ndj+zuIZJCSNHIzwxHcT4cVpEHC47RKIOgJx
         Uh1H+wzYYrWkTEQimDL4SIE73mfo/wBimJ8EVbXubaXzB7Zm4c88zhhM5HJz5lasCact
         UJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558701; x=1762163501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho8xn5k/6fWo/MTrNIO/VG1OI41Us+9e9ERYp+B3brM=;
        b=ea1Zs0e9Q1nn1HN8ZGAqAfbJLee5RUlnwj17sv1lbElhu8yABALpzWHzIH7UF13yPO
         9NC6nkB2cP7Jlx6sfODFsfFTARpBCfNXVcBIqjgEHfNk5tu26jO1O43EXskXYkAnYsGW
         /Ee8F8eKAknDohAVpqku31f3QyVUl5x8I53/04r3cxMN5Bs0coD3cu6mxy4IKZkBDqQH
         N3d248LMxm5UGYppneDe7k8qsgoQl2bViwuE8vfgeSaLJWYisN3tsUUWKgDL7ECtcFfZ
         xcq7HxA8Z5DNeO1OaPTC2Eiz16yD1JzmtwAotj60vkJ8dXEbBd3URLh9KsKHacjgRoxc
         8EVw==
X-Forwarded-Encrypted: i=1; AJvYcCVOHl9j7+F/movzzIotIv7zz5R4YKq5DE2IuI9JEwY23qi0nQkM4ezK0G/JjalfnTWIinh4VUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfvQPRAmf/jJQlIUYq/MNT3MwHF3eF/Qls/NJgI3/dMmpv4jf
	U4LyoB1PCsOEmhmjt/7++NT5cTBBg6XAuvodW10AwdGfY5TTFU0I61l2Vf+Hzz6pcW4=
X-Gm-Gg: ASbGncvpKPHdq+6im4PAnXBw/WQcEyoL4QDANpQHr10XgUQ008wZ8z/SPw8fSTodKti
	ICM8DB7/auF7cYNLSZmsEyx59w/UZL6Rf0CPTkXQRhhrr06TY7E8qUf+JBbqTITLjqre1+WSU54
	tj2eaxDoJUYSOeI+hZYNj16kthNwMNv2e4swoNfpLg4GTSTdJOStgXcqF3wcWgnSpoB6QCSQYaN
	c9RXyJhTHTyt/WxbuOpEvQIm5QQq1Y33oEJX0rB8tEtDj+IME/a9bH/npGE5lLBwqpsQwDHYCnf
	akbucUFOGcfQeP+Bf0rhW7eqeu9xxFu1BenqcEaLmUplpxqie9mYsABMtk0Vfw9WJTTiRy2LcZm
	wP+m7woeclZOxzlKS12RAAadqwTkUIdZMX1rQrz4r2aZ2Awi3DSTSxedlljdEp/DRQXg89e5t9O
	Yb3VGX8MlaQNQ=
X-Google-Smtp-Source: AGHT+IHBkoxPxf8kqFm1f4QYWTa891H2PsAiwWjxVPRrmr1FmGXiod383Gk6kRODuBEd54f6Gl7K5A==
X-Received: by 2002:a05:6000:26c5:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-4298a0a8eb6mr10250190f8f.32.1761558701224;
        Mon, 27 Oct 2025 02:51:41 -0700 (PDT)
Received: from wow-42.42paris.fr ([62.210.35.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm13125062f8f.9.2025.10.27.02.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:51:40 -0700 (PDT)
From: Paul SAGE <paul.sage@42.fr>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mchan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul.sage@42.fr,
	pavan.chebbi@broadcom.com,
	vinc@42.fr
Subject: RE: Andrew Lunn
Date: Mon, 27 Oct 2025 10:51:39 +0100
Message-ID: <20251027095139.399855-1-paul.sage@42.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <6e1641fe-e681-414e-bd51-e20cf511f85a@lunn.ch>
References: <6e1641fe-e681-414e-bd51-e20cf511f85a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tg3 currently call eth_platform_get_mac_address to retrieve the
MAC address from the device tree before trying the mailbox,
NVRAM and MAC registers.
However, this function only retrieves the MAC address from the device
tree using of_get_mac_address.

We are using device_get_mac_address, which use fwnode to obtain a MAC
address using the ACPI, so as we understand fwnode is an
abstraction layer for both the device tree (on ARM) and ACPI (on x86)

If true, it could be appropriate to replace the call to replace
eth_platform_get_mac_address with device_get_mac_address. This would
avoid running the entire function only to later check for a dummy
address.

Do you see any regression possible with this change ?

