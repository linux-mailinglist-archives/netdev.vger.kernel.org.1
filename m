Return-Path: <netdev+bounces-254794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKwVDNpde2kdEQIAu9opvQ
	(envelope-from <netdev+bounces-254794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:17:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C886B04C3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794C23019CA7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11A13C8EA;
	Thu, 29 Jan 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xx23ToAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6E6FC3
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692631; cv=pass; b=to3tOWqUBpSIA6C6pTHm5YxXFo83DDzcz6t9Cd4DCvGF6e6l9K9gDCfC+s34fp4nLBabnCGTbZIMNfCqXr49LZiocCrUm2Xuo4r1gUmxt5gfZrD5I9Q5L40mM0nzKn9hBw+fmNjVdlXkgOaqjP/PofqUyCvxN3yny9FuN3OHehI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692631; c=relaxed/simple;
	bh=w1MToCWiKnhg4MqrOXD4KVqBFRvlwVspzuTHEaUNGRU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W5xrWT4NREjZnxsS8lBZUtBg+DJX4tsG+GINh94gOsO/Kp2AdTDhp1Py8hLHEO4nSceOGAkrmwH/Nbbzdi7pPIeuPrqb/tBp+d541UIM8OmTfCTcHkE6efK28qgFXfnGqpQ3rf7eXzwnJCEJys2TJHAUd0lT9vpoLtdq0oHpQ7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xx23ToAE; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014600ad12so6878721cf.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769692629; cv=none;
        d=google.com; s=arc-20240605;
        b=Jk/ITeLYDm2St3Gn6DJSwylS3+F1u6lQAhyRZ53FVJ0gLAynoZjb9r+Aze7UpcP6SQ
         B3e9LkBuZfyQpGrSWzAH12J6aL8kgdZtgMnb73Yw/g5DBAxIhz1uhoR8A2GwJz39NbY8
         Owi2pRpRiCrYP7rbza093KP9J2vT9nx0E9OJesCA755BP19LRK9BfQdlHbfNN102MPDF
         c6jakwH2hD7CF0zZmsDvKywZamS6+WhIEbioKrChh7jSTHM8nX/R/pHgfPo8MsoEGzDT
         wIrerLcINv10uCa53rPZGoI7dyk8tSbeH3LY/g825APamQQv61QHqwIxlGcMid3i5PAh
         vd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w1MToCWiKnhg4MqrOXD4KVqBFRvlwVspzuTHEaUNGRU=;
        fh=XF9D9mEc9mpRITIi3orLV6pufpVAYQsCAvMR3TztLHE=;
        b=BDmrC8pTB36KWYLZ+XJYsZecwQaWMC3b80fRgLeIh4RxO4ztThcbpeyrlA2Ypikbm6
         g9xMZVtNab4tQg9u10S3ncelMxjaG6nkkvb+nDRVtALvkSv1AwyKtdEuoOmi/YJCLOEh
         3+ZohMVitzLH3zvnzcsiXbnKlOTzf74QkYgUBaF8DxL8OwBN7AbPOljOLFZVsAEs1Szh
         On0K4domHK7S/bEPAwTl4Oi5RpsdseYSBRqe9QXVLK4qohUllIVvio5lQUOEKLt8OzOO
         p+PkQC/0OA8eapJCGnRmQuKKSKzU+LK0kcMCvFhoz0B8buAUpqnkcN1PceRWf8qPAv9E
         dH4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769692629; x=1770297429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1MToCWiKnhg4MqrOXD4KVqBFRvlwVspzuTHEaUNGRU=;
        b=xx23ToAE0H4424J3jRVQzkdF3+kOwp0FH0zcheJabZEkQqKzQJAnBsKJqTvGNFDN6h
         NhdJk6DQgMKp2iwV24zDglE5q1ICROv0a2OrhBHtQZGm6OZ3ORkoOBOmUCPSsZl+K9jw
         ieUW2xC7vjEBUMhnQ9QllONgKIWi9952k15eKHieHsdADrYTUnerJ9Do/SjY1jvkCh+r
         Jb/UquRhxaaWMlaIU2eLwZA0vjNT6r9uwj2wlQkT+bgtFQBJSxkeX+pdu57T4DZRjW+f
         7l20P9EVgXhFwZTrmq49zWBQj9U5/wNHRYPDlyCOeKP2fhvebo7JwrFc/XuCNZWXex0Q
         0npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769692629; x=1770297429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1MToCWiKnhg4MqrOXD4KVqBFRvlwVspzuTHEaUNGRU=;
        b=l4xd7f/gKkOqXxnSsr0M/Z8YRdkCQsFe58pAqsD+L6l0/Xw6mqUjN89+91E/W++D+7
         DjVX4q+hvSpwMDHxeWFPvNJoiji/egp02didYtUtf8VXqMHvF1JC4RF5v4QznQ4R8Z3A
         bYb2Z0KVZrKfheslgDYrNLvBVEEc8h0DlsL+v5BuvQSKYpmLGoUWXv9iJMmbY8mXi9L7
         d3BRIE63PpOnduRwxKbnOtg4KJowIuHf6KX2qhS2/kMQ4Ev/n3t5BN6XFGxom49TLgzx
         3onQK1gdPgPFeogajiXZ7DOkA9588MArTec6zV7MPdsN9wl5foEFk194iEJVEDLfKBQ9
         w50g==
X-Gm-Message-State: AOJu0YxtoGDK+Dd8UyTdUWEz7dbzTOAbwg9/Cr2/beKmP0+bpY57o/RO
	zx3MHhSbZ3ZYJY0Ng+lEGPWGdWLz6POPy5jDQWKKGLflU9mqaS2cHxvyp+7XYcKe3/SwR0WxVbL
	RkUEVrSy+MXfPhsoEkXAljMvbcFb8pLfm1+i/z4AZ
X-Gm-Gg: AZuq6aJQoLjGG9RO4nAGbw6oEcDcRii9c7LfhmXBoEKKZgEq+eQsvPlmyQWUqZFhqLn
	ayInHsqDxl39VeyswDxf+BqClfVIVqgN9cSkXrWjy577bkyiPMH2CjeSz6Xf/ZICssA54HFyZU6
	ELAPNFygN+sqdr/oIxf6es6D1Va6GSaDQcB+HbV41RAQAU45ppuKbnXe9At8dAPinxXXhU+9daX
	3C2dDpuAauDNPYVlNLGXDCTLAgzxKwnDRGjJUyvw7Snevzgs+JgoC/D5cyh9bA/iI0EY04P
X-Received: by 2002:ac8:5a0e:0:b0:4ee:1fbe:80de with SMTP id
 d75a77b69052e-5032fa1e915mr109584791cf.63.1769692628133; Thu, 29 Jan 2026
 05:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Jan 2026 14:16:56 +0100
X-Gm-Features: AZwV_Qjk5FzIySEnxsqL3dd7XsXUbfDhBxE5VBWchboPJxVm4swZa73EwBt4PQc
Message-ID: <CANn89i+UsejDXBJv-SqPJTCb-jO7p_+28zVLOOxvHoyV2MKwCQ@mail.gmail.com>
Subject: [BUG dsa] lack of barriers in netdev_uses_dsa()
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-254794-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9C886B04C3
X-Rspamd-Action: no action

Hi dsa experts

It seems netdev_uses_dsa() does not have any barrier.

A compiler could read dev->dsa_ptr and get a NULL the second time.

include/net/dsa.h:1336:static inline bool netdev_uses_dsa(const struct
net_device *dev)
include/net/dsa.h-1337-{
include/net/dsa.h-1338-#if IS_ENABLED(CONFIG_NET_DSA)
include/net/dsa.h-1339- return dev->dsa_ptr && dev->dsa_ptr->rcv;
include/net/dsa.h-1340-#endif
include/net/dsa.h-1341- return false;
include/net/dsa.h-1342-}

I was looking at this because I wanted to inline eth_type_trans().

Note the wmb() in dsa_conduit_teardown(), which is not good enough.

Any suggestions?

Ideally, it would be nice if netdev_uses_dsa() could test a single bit
in "struct net_device",
without a dereference of dsa_ptr.

Thanks.

