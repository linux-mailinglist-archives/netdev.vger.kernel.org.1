Return-Path: <netdev+bounces-107622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA791BB7D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E229283638
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7F1509AF;
	Fri, 28 Jun 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxaEmX18"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120CD2E5
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567062; cv=none; b=JKfQ1w6T9evuTSD5pBWpSTw5jbBnWfADkSmxPCTu1TyR/DhkUjBNmAWUbc56L3ep9tCF3hRFIlfA6kUFmpG7zzPBD8wTRPJm+128scJH7AKz5BT8eLIZCJDNA1FPxn7KQ8GdjREovJyAweGSr8WCivJcA69gLK3/VMhNEUuDPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567062; c=relaxed/simple;
	bh=CcRbXR+YBhanDRTa4pGsZKklaexJX6NQWdxOrJx5Vgc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=keX6u/Ia5s75zEemKoET9Hf096iRb3+3HpIvnSxVldOqEjRVxWV/pxpEaV4eDLJSa2kz/DuYJquHusFiKS+9in82bU98RZSgr3OxdcEimCoStYHTDUON0FgObdETLQ4sCen2Fry3LuA3+Mexh2pr3JGDiiJR6OIWRfBUep04f2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxaEmX18; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48f350bcd89so147007137.2
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719567060; x=1720171860; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=chhuL98xHn5cV+JerH5BQ3m9aH62TU5xhdX+T+AJAjY=;
        b=AxaEmX181SE8HN+21uJmbwjhAPRdNVgLP8Vt+sUo3K7GFyhRlvsII1hLInj1x1yg1K
         5Rk0Fk4iAeb6Kt0nWsl/4/rm+IsrUPWOD6rt6WX6jMT6O5nFBQQqzdnrss8sy7lzOL6+
         qzWrjOs1GB8g2agVqD3DGQEhMhC2doT0Qs92C7EzC2YBBGWssnQaKhSkBsvBdl/xWxbo
         z4OVZSBQsjjgdUXpyttM2p1QCFNXiKkjNYeVJoJOxd1Gpl3IG46vvEJGKZ7dyEtHvbRa
         T11RSYUs4iV662MFXl8OPaq/DohwHKU47+q5b6v74mNGh12M1DXn5Ms8UixxgBoxVdfd
         /TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567060; x=1720171860;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chhuL98xHn5cV+JerH5BQ3m9aH62TU5xhdX+T+AJAjY=;
        b=w1c9yoWhWsO9KYa10OK+u/zWhtr5xNJ0ETA5ay3cTcARct3aQroYooJFoyXhV4DnFU
         p7hbXhndaGGqrw44ztNhUqgk4eDJfshcIi1WhIbZSZpLdP82eyM38eGP/PfPV6QEY41e
         b3pP2j0AS72Tumu/ciL9DyB95gXF0gOL7IxQz0VP1VDQnxACY0mgV+0J/H3MNd7E/Ovr
         iX1/gAXg4HcYGHC2xXclx645KdljlxlhdBvht76rEtvH2xKsHhJZEHCGWBIAe5h0atlr
         /ql8x/fOQMNfYDJJntnFa4l8PdbFqWTy2XLnNuXR2NOob6XATzVJ8Q8V6Q/J9oPrJHY6
         hwWg==
X-Gm-Message-State: AOJu0YwDlOQSv6tavDB4jMdJqaQg6dygTCO3iFvo9A8DgHqkK28vc4a8
	RUT7waGUPCHzyfOD6BRkkPqB0x4HbOUkMaGGnox65dXSxqQKgpYmhEh7+EtlG0g31CroyrV8gOM
	G3+sNx0V0RudOcg6EOeH2guHpuj7yyw/o1BQ=
X-Google-Smtp-Source: AGHT+IEAEBIM+6s7sqo4HETuzr6wXz0Pygu7NpFiZGFRKCT3/hG8jpTS1/CA0Uktz9283/RhHWPD2/H5aOvHquxnJp0=
X-Received: by 2002:a05:6102:1289:b0:48f:385f:efc with SMTP id
 ada2fe7eead31-48f52aef615mr14688486137.18.1719567059874; Fri, 28 Jun 2024
 02:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Jun 2024 11:30:48 +0200
Message-ID: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
Subject: IP oversized ip oacket from - header size should be skipped?
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

In net/ipv4/ip_fragment.c line 412:
static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
                         struct sk_buff *prev_tail, struct net_device *dev)
{
...
        len = ip_hdrlen(skb) + qp->q.len;
        err = -E2BIG;
        if (len > 65535)
                goto out_oversize;
....

We can expand the expression to:
len = (ip_hdr(skb)->ihl * 4) + qp->q.len;

But it's still weird since the definition of q->len is: "total length
of the original datagram"
Which should mean that we are comparing total length + ip header size
instead of just total length?

