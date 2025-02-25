Return-Path: <netdev+bounces-169493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6023A4436C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43131421643
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49521ABDE;
	Tue, 25 Feb 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZbh/dVP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555121ABDA
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494605; cv=none; b=LH51W5YNuVzqQ89yYYz2AgBvDGXOKXDBsve2b+zb2YEMrvhw3f9o/lTJRtfearMtcfXZGfns12umWocE6dq075FdfrqTDSf8Zx6FwJyvaaCXDu+OW+AAOpfGJdLX2eW9yNAtB3MdnEltgYOtXKg0khGhDKFRaytIj7NMlWiaPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494605; c=relaxed/simple;
	bh=TfFdmFzTETqlhhVxDnxdVRDF+x0N9DAM6Nq/eK5rnis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQOBeyE1oGgAHYF4oohCgc/MEiJH9V+j2r6lToi4OGazk1e7OMm3usljpHwkTACYoYyuXSaLUXwRJrCrhlkan0sG3BT20rsve6FQTxJhnAbI8fyxHK0mDQuKHw46fuCccDFvDtJH1lX2bi6ixRspKWqH0ZDBQo0iovB31fFluhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZbh/dVP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740494602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=z2IuNxX2NPMxHmnsxTa3HIddhf3xrEIXhrl9Im2LlOA=;
	b=WZbh/dVPjHspIOTdltfIM9bAfaW2MaGqGIsWXcqR1YuUkEc6Ant8R8hG3zJrypVnnMFqkd
	4e8aq2+uiMbFL8skVj+VbQGrSFNqJn5HefLi3PQiznzckpXBe/svnKTRJMke7YcNKlaJHi
	mGdJnYMX8NXQQ12ZPDCSDWmQy4egFCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-yoyKFL6YMSm8xadkRR4wWQ-1; Tue, 25 Feb 2025 09:43:21 -0500
X-MC-Unique: yoyKFL6YMSm8xadkRR4wWQ-1
X-Mimecast-MFC-AGG-ID: yoyKFL6YMSm8xadkRR4wWQ_1740494600
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so29336195e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494600; x=1741099400;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2IuNxX2NPMxHmnsxTa3HIddhf3xrEIXhrl9Im2LlOA=;
        b=nz2+h+fgP45YJJAJXB+YTPRFDyW553q4V1p14uWfHoWDEuUlIH3OdSMNquoE36hnL2
         DGgSAOpkfYqMO7PtBF7IfY1NbXfEpPxIB3ByFlLaLy34xkq4zdBlYBEv0FjG1v/Fqt2z
         uAf8qY83yL2z4D6xkTOWv3mx2ljXDtjASpJqxzV2qBH7dYSmrkkB4+w56m5Plo6vpGJR
         lyEz5cnwomtzXEL4J3x13HcbGsdOZVC+ocr1+Q8jQNbH2v+nCD1slpV93FU4xPAqZVnQ
         lUzf6E+HxCWrnIE07alNMxwYTgtHh7n+h50+5eDn4gH1nzuqcLT79JrC/t2UyW1FOru+
         +I5g==
X-Gm-Message-State: AOJu0YxMElRPubDUmxUz0A/FTrlrEIAYIYBJBst28c3IqET/zqhPZ40q
	t2Ek6TlX4WzlzGKTaAVVfJZXlw1TnA/mGFY6zu5fvlZKux6GeDxxhWLsP/jgPS7e8xzHcWzlygb
	VrkP/b9HBOXe17wANO9EvVkq7R8+k6ZY4bNN7YtFreH2TM9aO6c+pqQ==
X-Gm-Gg: ASbGncvdzbzeGnhaFBey+D3SZpc3eqM1LiRBNzyOUy9H+87SQW70mQYMKGauLjoS1iR
	gdT7IPSAkN7GGCuEjmbBckc9TW1w0K00aatK7pKUorsyRt29ZxXIE9FWHr9a7aI3KG4Z4eXUCEx
	5c9hlJBeaMFJoVrlRjr6BnfEKKIwi7VseclhX/JaIioD7Mw3ib3aAvsr9NVlQxbnjJ5miegwopt
	HyG51WCjpqtAm8iNsfhp6oRVUH0/RKIq4rrMf/u9FcCIjUOfsPrwULPaMHXUzd+riv/pE/++lKF
	opk=
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr164275985e9.14.1740494599938;
        Tue, 25 Feb 2025 06:43:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwc3yZF0TXJFXoc8xCSWpH2Xvbffd82tkxYKpR2BESliV/qJXm9VDE9+cJ+IufkRMkDZcssA==
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr164275745e9.14.1740494599608;
        Tue, 25 Feb 2025 06:43:19 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1533104sm29184555e9.5.2025.02.25.06.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:43:19 -0800 (PST)
Date: Tue, 25 Feb 2025 15:43:16 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net v3 0/2] gre: Fix regressions in IPv6 link-local address
 generation.
Message-ID: <cover.1740493813.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

IPv6 link-local address generation has some special cases for GRE
devices. This has led to several regressions in the past, and some of
them are still not fixed. This series fixes the remaining problems,
like the ipv6.conf.<dev>.addr_gen_mode sysctl being ignored and the
router discovery process not being started (see details in patch 1).

To avoid any further regressions, patch 2 adds selftests covering
IPv4 and IPv6 gre/gretap devices with all combinations of currently
supported addr_gen_mode values.

v3: Rework patch 1's commit message (typos + GRE device types
    clarifications).
v2: Add Makefile entry for the new selftest (patch 2).

Guillaume Nault (2):
  gre: Fix IPv6 link-local address generation.
  selftests: Add IPv6 link-local address generation tests for GRE
    devices.

 net/ipv6/addrconf.c                           |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 227 ++++++++++++++++++
 3 files changed, 237 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

-- 
2.39.2


