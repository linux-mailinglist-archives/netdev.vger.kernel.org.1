Return-Path: <netdev+bounces-163156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55DA2970A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4537A1FE7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E21DDC28;
	Wed,  5 Feb 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GETwsoqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD71925A6;
	Wed,  5 Feb 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775814; cv=none; b=pDb5h7891hEV/7KTQ9NbGPxrTUhmOKVlU5lkIidmGsaeVsUqknAdCvRsLR9qXkUAdnkqJkA3UDu7Ss2eN6uZc/WyUCzlwa3wLzVC+qwY8PXMhB8LBl+V3jkEXBhFZKdkWmTUzF85HcQR37iMbTxCrSCzAXSDRzRR8gabuHx6EBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775814; c=relaxed/simple;
	bh=7FnIsT98UB7XXcLMJHXZwOvAfPFD96HZwRZwJzM7x8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onIONX7hFmzvps6Y3DF9tzhciuYh3c48oMvlvw0fDwUjKIn9b3cw0owBbPGEkQ0rNkW6fSnCUTL/6l2a3xl9GjXBac5IxLHrwemGS6ja0whYY/EXnTWjlkLr9tR9uUmsRtby1458N8YvGib83KZuYKvUew+seupMrlHnqz4fZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GETwsoqw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f664af5so75515e9.1;
        Wed, 05 Feb 2025 09:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738775811; x=1739380611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tI+bZwu6GewhEvqehxISDToAzrtq4zhF3HJXjZqxcpI=;
        b=GETwsoqwrDM6MKTud9WU5wz/bfAjntdwer9q8qL25ULJIdjzrEbi0MQ8gE5Lqd+O8e
         uiPwjO2UVJx7v9Ls8dIa8Ga8H3Ct7VGIA/PDh7rPNm6kCGmBV0N5HcaHVKpOgoWAWt/D
         i1g32qVjhKDMRwqaZa60M1dO1CuF/Tkwa9Kh5uqKC/zXu0H3OszyefZAfiCiJ08an+oT
         GPpR/U6cDKMtBC4PgD1v1O9f+WOxfPfCBGitpGM3CHWqLe9dMf/jqYgwVJdGC+sBmaw5
         0jX+OgvVhzy5TvcjRpgoYdw0IwHXTPpoRHulePz5hGHklXgrb7dB0581Tp9xd6Ft9Js4
         XcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775811; x=1739380611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tI+bZwu6GewhEvqehxISDToAzrtq4zhF3HJXjZqxcpI=;
        b=P/L0RGl6A9bsoKK6UYQHKrT+QOZwzfVVGVKuk6AeacowVLE3xpJ+qxHlmF3JgIK9Ce
         D3Yo3GETs0GVFGCLxuntR9wAwT2SFLCyc4rF8woIeScveJlQdZA+FWxbl/D7jaHQv9CJ
         6ap51ldHzD1rFCoHgIgy0TrxCm51h+H/USXcg6xnuMb1WEfv/7oIWzYj3n/oC3uScjtW
         Z3grjKfcWlRSlSX9ys2vpahnAKnZXlb64qzOwKM+dEgB1svNbGq4C2XZ1vmhMKVBNUnd
         6qHsYhuHiKZbe/HaiPp+x2TPQ3eIt26H3sGwcapo74zutWsUt7fq2uu5/jXLH8UfxcZr
         T3hw==
X-Forwarded-Encrypted: i=1; AJvYcCXZVJlFuZfKEcnyWmXA8s768QT9CJCEH94PQsFIUxhSkgDi0uBtZUGcTXBURLOhPYIU6qiliJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLVBhiTKe8YS+lF4B2H9nv6LJuQME7A6fw8yqNfMWeWeWAK2C
	X1tIsmDrGD6HERuhSRqe1LDZoj5wIwFINyD4b2gg2cE9A1XMIZR0
X-Gm-Gg: ASbGncu3QCc/CCYbHbqLYbZLFwVaoGy7OKE9ImbjKy6XqUshK9XG2xx65lpaHkwP/pv
	vSelFfAwfrMTq246S6exzbIuTRSnraXqNBuc2CNVzgRBLxIun5JXBoIO8sQzA9VvlkEECeLl/9H
	brHJBaC7YpO1MPQ963KPo7SrfDLhvwgcF2k2Uiy2chk0Glguf5xYWLTySEJRHGs8BZ/wxKJ/7Bu
	ib8vw7/ta1itKsuy38aZDkiOyGJME5ExaJfGiXSfyea/Cla+EywYvpp2myiRa251LAlClZFlJE8
	T0JKvkLrukYWqPrPPrtAkJY+sVKTpAASWBm4+qiOFw7oBw==
X-Google-Smtp-Source: AGHT+IEu8+O91tkNGpL2qhoL065w36lIfzSCqdh5DqwpTYS0cj8l8Eq4Vtd93nFSPCTRNIfDmR9xxw==
X-Received: by 2002:a05:600c:1787:b0:435:23c:e23e with SMTP id 5b1f17b1804b1-4390ef62be8mr28141905e9.12.1738775810845;
        Wed, 05 Feb 2025 09:16:50 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4480sm27185705e9.27.2025.02.05.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:16:50 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 0/5] Add usb support for Telit Cinterion FN990B
Date: Wed,  5 Feb 2025 18:16:44 +0100
Message-ID: <20250205171649.618162-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usb support for Telit Cinterion FN990B.
Also fix Telit Cinterion FN990A name.

Connection with ModemManager was tested also AT ports.

Fabio Porcedda (5):
  USB: serial: option: add Telit Cinterion FN990B compositions
  net: usb: qmi_wwan: add Telit Cinterion FN990B composition
  USB: serial: option: fix Telit Cinterion FN990A name
  net: usb: qmi_wwan: fix Telit Cinterion FN990A name
  net: usb: cdc_mbim: fix Telit Cinterion FN990A name

 drivers/net/usb/cdc_mbim.c  |  2 +-
 drivers/net/usb/qmi_wwan.c  |  3 ++-
 drivers/usb/serial/option.c | 26 +++++++++++++++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.48.1


