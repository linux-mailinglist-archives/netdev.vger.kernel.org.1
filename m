Return-Path: <netdev+bounces-130993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856FC98C58F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE24284D55
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29E1CCEC2;
	Tue,  1 Oct 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq99070V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90D1C8FB3;
	Tue,  1 Oct 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808373; cv=none; b=XcWKqsgbS4tBr5My9JjD3LJsJHxMKy42BiTN4KY/xWI4ErTpa7aMumHIYtzgdIggDjFhYdRrHzTcTJ/CcM007yDbvFbDaITLypHRK5QHXlUO/X8WyOCuwhSzBItTMYF0xxCV7llmXiZJMr9aBgHY2RaTHAGdAebXJk9Bh5MqJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808373; c=relaxed/simple;
	bh=gQcK9Ay3RbtRXyX15XkGzVq6aLBtG5kfSFAFm0OZfG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNjRIGCA0IOcugZGIGaDVwoRDtksldcm/fz/pV7Y90jouoUp50DWdkBqxPDxyp0jJRj4h+KzLz/L7CuQaaIqghRa2z4lbZFDcqp1JYKKdb2a6oslNHlfUYd/Sg9+z3NeEGWXDD5dwez7ATvhaG073coVL6bujOW3YNHaj+qoZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq99070V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ba733b6faso13838015ad.0;
        Tue, 01 Oct 2024 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808369; x=1728413169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwOVd6Di2C9YvO+Aj2Kvc5LZ0AmnYBL6VVrLYk1OQJ8=;
        b=Iq99070VwJypERo8BgztvHx78Ye6QkzhoKo0xaXyyxVWmEZzY6puV1fxs662cO3V/7
         z/D7iZuPN1n5W3EMjymelTkyNWuM040Mds7x8HhdIEF05w+CYypNlc5O1pmq8mxIBqKh
         KvILkzhoGPHhLAEJ7mraIcVy9XcqKkqgT/SzvxIIW6RlML0fCFEg0PN2Y3CKGKvmt3cj
         Ny/hCJ0aX0pA41wUctH44IzS0whbGZFKRQQOseJa/+OqDBaTSQvK8ajLqYjL9wVQBVaO
         f1njOKYtb1bAAdW3epWb2qud2fMnUIQALO/Rb3pnHgMquRc9n/eons9PEtmUG8bMJZVk
         ekJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808369; x=1728413169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwOVd6Di2C9YvO+Aj2Kvc5LZ0AmnYBL6VVrLYk1OQJ8=;
        b=o0pxS5t913awoUyGseCPmSqnLyWm8SxwT4iPK06pA4xd5ppc6B9UWQWMctcRGSWVBx
         indjQoYwne7XTTH/YzNy0i9g7529FV1flvXFEG4iE/6LJJ4eCfzRf3mr45dNGfYCeYnJ
         eHL4xBhnpqPT0/lJGnDVAI6eadMfkmj46/whv/irWhcmfWP9Rxeowh2lDhsswmGiaYGH
         0rt6NVQE9LbIawvc2dm3K23+0SEAqz+tTv+E7TOf1ISLzeSRktQh/6uK8QkmPzi58uQK
         JtCt4F1reKgKk3nnmQ2xB2/pMH0QSc837hUm8VyFR62yg/f8oHvoj3uwbulFBrDj7hBh
         11xg==
X-Forwarded-Encrypted: i=1; AJvYcCVUHl4OltCDJGhvGdMNks3cERvMH8BsrrhBN2LiowNWEXn5arxL57oj0oQzUgmbsrWxGj8+5CwsSPlaBIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkB/GX7KLVpnsJuipzf+rY2quy3yEv7YMltCaIFnJIDmTy9ZEa
	CY14WEq4B1YmiZrK5Hdo7JLfR00Yv+VDlGmwO8705gv+uMx/79jqnf9t2ciJ
X-Google-Smtp-Source: AGHT+IEv5Uuxj1nMXpPFe41yJZa6utFylGp4xNyCUSW3fEYnjKuv2qxrK/EyKYQOF2QjE7DhuD/oag==
X-Received: by 2002:a17:902:ecc9:b0:20b:8bd0:7387 with SMTP id d9443c01a7336-20bc5a876f3mr6831875ad.52.1727808369212;
        Tue, 01 Oct 2024 11:46:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 00/10] net: lantiq_etop: some cleanups
Date: Tue,  1 Oct 2024 11:45:57 -0700
Message-ID: <20241001184607.193461-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some basic cleanups to increase devm usage.

v2: fix typo in devm_platform_ioremap_resource

Rosen Penev (10):
  net: lantiq_etop: use netif_receive_skb_list
  net: lantiq_etop: use devm_alloc_etherdev_mqs
  net: lantiq_etop: use devm for register_netdev
  net: lantiq_etop: use devm for mdiobus
  net: lantiq_etop: move phy_disconnect to stop
  net: lantiq_etop: use devm_err_probe
  net: lantiq_etop: remove struct resource
  net: lantiq_etop: use module_platform_driver_probe
  net: lantiq_etop: no queue stop in remove
  net: lantiq_etop: return by register_netdev

 drivers/net/ethernet/lantiq_etop.c | 143 +++++++----------------------
 1 file changed, 34 insertions(+), 109 deletions(-)

-- 
2.46.2


