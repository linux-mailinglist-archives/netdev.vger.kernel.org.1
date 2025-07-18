Return-Path: <netdev+bounces-208140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B684B0A38A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16591C255CD
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A92D9EDE;
	Fri, 18 Jul 2025 11:52:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2AD2D9ED6;
	Fri, 18 Jul 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839536; cv=none; b=ICLotZ3EzB7XXMNGcdqdKDtxQAqVVsEp8X9CVnT7l26HpzeysYCy9Xn8T47rrRhnxZDn+JOSrj6jCH+Ej1JnQtngmrFG2jopIRDFXSWggS7cSJ2O+c5skj317T4+PQ/zm//Yp0faNJIz6CrPbnQ+hZRWwMSDpE1NA0tkGczDRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839536; c=relaxed/simple;
	bh=npMKjlKvV+IPTdDrHEuWkh+06utKvMqF1s/Hy+KmptA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f+AuWAf+vXHu7dP6dQh5AwX6afLuOtHF8ytTMTg1jzBp+tKoQJAUsdGktGVzlYPvoWNzZDBhPaurb2CgwaUSttEQaHHRUYAhyHA6oKBaenmVlF86qgZdCEWDkglV3nKVdkUxBkGGFBuQ9DbrymyXtdXdRUAGq1birOSK7HPUO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so280939566b.3;
        Fri, 18 Jul 2025 04:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839533; x=1753444333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCv+iJyMukbckgC14VcFHFnZ5ptEIW6dmB600qdESog=;
        b=NBWU+Xm066IWuzw8bOTyA8NYZVQs+EOFMh3oh/NcqqYxZCZiiM408pkPzPkm6EGVGk
         0mdRlLA335NH1M/qhl3b0AicthT4bbCxo3JvILAb5hTnBOkqa3wsiEBAaQAdZtA1umW3
         2IJgBpgoJWlI3g/ARlc8m0pxlZuins+3ePzOaVXIFN2Tzcce4eYJZn7O28r7NgdOtopo
         WaZgFZHI8guIFHCr8eFxng90J8kFwgn9oWPPlVApRtPbMkp8bF+04Xs/sMsnHZbH/b+1
         2BOhzynKgYZqviKF5spMhrJgy4SiP5iqEer7AUTQb5dkbylqOFdOMHtyuvHTYP1IJiLk
         JyBA==
X-Forwarded-Encrypted: i=1; AJvYcCVxuUwJ/1XILO8q2OH+Q1CnB8Nl3ILDog1y0BSIFwhxpga6Zq2vhnjuDvlT+39jdRUo4nLEIDaRu29AZG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzHasYHhGng7aLNAgRSBNRs6QTANRbjsINuGhex3XBzhUjfjJ
	ipXu9AciIa3yHzNii6Hzl6YjiG4Aa9uJaZa6kfg47NKwZlzQ524xXaLC
X-Gm-Gg: ASbGnctHY0v5TJeUE+uBk5QsQL5d3P3/U+gZ+BvvN4/5JJaCVKHCWDLOICBHJA6rDe8
	HoJRH7PAwSsO86Hnx0drLVcBM37pxQHN2zyigyhWN989lkxAVqks73++fxVlUr/lRiDRctIkYVI
	MZX/uYX9HPypjJ4Qn92Lck8CpsVxuXFD2/nSLFz+zviUi3In3G6fXhDlNKLdzuOQC9y6mi3OjBi
	5QMRLwCRQGVNRkSfmOGdwarh+nrEdgGZV8GBbFLfF9RaL18s2VjFuWtUku24HGCAONDxktQLf2c
	oixsD8tnx/YMAGxXXQ0kvdBufw3jI37PTuqqnnu0M1nYnwPjyWNvAevYfAQC2QRDThP1fcEzy7W
	y/luJFgOhST0f
X-Google-Smtp-Source: AGHT+IEprySthQCMqusnvIxSF/8F8dfGbtzaE0qt/aE/bw4afDS/MNh1+yvFQi9Axg1I4z195w7RzQ==
X-Received: by 2002:a17:906:d54d:b0:aec:578e:caef with SMTP id a640c23a62f3a-aec578ecd38mr513792266b.35.1752839532776;
        Fri, 18 Jul 2025 04:52:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79cce7sm108884766b.24.2025.07.18.04.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:52:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/5] netconsole: reuse netpoll_parse_ip_addr in
 configfs helpers
Date: Fri, 18 Jul 2025 04:52:00 -0700
Message-Id: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGE1emgC/x3MUQrCMBAFwKss77uBJhgquYqIaHzRBdlIEkqh9
 O6Cc4DZ0dmUHUl2NK7atRqS+EmQ33d70ekTSRDmEOfFn51x5Gq9fnhrLC77soR4yuURPSbBt7H
 o9g8vMA5n3Aaux/ED9tPCcGoAAAA=
X-Change-ID: 20250718-netconsole_ref-c1f7254cfb51
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=leitao@debian.org;
 h=from:subject:message-id; bh=npMKjlKvV+IPTdDrHEuWkh+06utKvMqF1s/Hy+KmptA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoejVqBYxoPaX9+1GlL8GyWHrdTz43Y1QYqfkbF
 PmLDkd6AF2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHo1agAKCRA1o5Of/Hh3
 bf/cD/4z6csvtbMtaCJOZNKGbRviiIz/JFUTmnN8xrWAmia/XLwtrK0MXVBt836iX72eFKrIJG1
 hweOBcSBZXQRj1shkvQv0NtCXKrO/thXdS152GWXEfcEs4EPtFhGrBLCNC2wq8AYQ8MYE0A9HtO
 pK2xGWAhRNzte+Yz2MCoRUpZhc609TGpx5rZy7Jek3IJniv86mVAyc/tLOD95aF6H6i1j+itV8H
 Pckqmvb1HnYyO/Hb4xbLBC7cIsai4UILa2WosEqZdwRJwTsNWOQ+HRHMAy0HyCDOFUMKzkw4LRa
 zuFyAybVPli/bJ0aoCT6Y39DTUgqFxSmFr2V6yYwG3FDKW6RWjZ8Q7L48eEglAcoOq0pV+cW2kw
 cqsj0Hc24DcKgvTDE0l5eW4CYODYsqsFHN2AxsYuc8YYHXpwj8YTyV6sr+CABEqwZ8FhN8P7Xxn
 4i89abG3Gjm/DgHoPDvLCfga8cilAkiOVbZUicG4li9cS5C+m1EjDIu3Y5P2axjRETJHS8phaYb
 taA33IEXe7jJv6YFdAUWBduJc4FwZI65uFKY9G7tPypEQe+O6jDr1hipk8AqDzBJ8znCyWtySqA
 fIffkDUe8kKx9TZOsRmLdWsUyVLWq1IOi3M9wclcMXuyqI443tEfhJALCqp25Y72Ia4agR43EG1
 /49AMFpdAv3N5XA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset refactors the IP address parsing logic in the netconsole
driver to eliminate code duplication and improve maintainability. The
changes centralize IPv4 and IPv6 address parsing into a single function
(netpoll_parse_ip_addr). For that, it needs to teach
netpoll_parse_ip_addr() to handle strings with newlines, which is the
type of string coming from configfs.

Background

The netconsole driver currently has duplicate IP address parsing logic
in both local_ip_store() and remote_ip_store() functions. This
duplication increases the risk of inconsistencies and makes the code
harder to maintain.

Benefits

* Reduced code duplication: ~40 lines of duplicate parsing logic eliminated
 * Improved robustness: Centralized parsing reduces the chance of inconsistencies
 * Easier to maintain: Code follow more the netdev way

PS: The patches are very well contained in other to help review.

---
Breno Leitao (5):
      netpoll: Remove unused fields from inet_addr union
      netconsole: move netpoll_parse_ip_addr() earlier for reuse
      netconsole: add support for strings with new line in netpoll_parse_ip_addr
      netconsole: use netpoll_parse_ip_addr in local_ip_store
      netconsole: use netpoll_parse_ip_addr in local_ip_store

 drivers/net/netconsole.c | 85 ++++++++++++++++++------------------------------
 include/linux/netpoll.h  |  3 --
 2 files changed, 31 insertions(+), 57 deletions(-)
---
base-commit: d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9
change-id: 20250718-netconsole_ref-c1f7254cfb51

Best regards,
--  
Breno Leitao <leitao@debian.org>


