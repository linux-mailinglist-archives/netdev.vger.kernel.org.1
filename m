Return-Path: <netdev+bounces-77355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCD8715E5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC58B21882
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271B1EA6F;
	Tue,  5 Mar 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TrRnU3wn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0892595
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620416; cv=none; b=O9DqDdq68qzy4YjYeGUJsbcHiU8RXpIAvn3P0+LM5vJRkMid60xesFZHgGSVKqAbzF38/+fZb7xqMOVMosIkU4lCyttmlxh3tyreX9O88eA5uEKC9CZgAb6valFh3hsQS8ZWtZIJegwdzehgMb8Z19zU8PZXFY5+YmfcP7JHYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620416; c=relaxed/simple;
	bh=yOKnBG+SALngK6Nq2Noi5qOW5wBRtGik6ENRyM7hsvE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=s07Uc/vl5CoRWYeKhtCXa55rDRlAwEIE451Uxrf0m7enMz2IhmgJNv2M22Zr6e8xACErMYRU4Ia9iD+fiep+ATD759CPQK/ejnGMKJ3DrQp18Ysqc4EiOXWlk9acdARy9P+YN2F0vgjNACirbKBdwsBErvxAlemv6QhXH3sCxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TrRnU3wn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6FF923F0F8
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709620410;
	bh=hW0QObVw3h/AjNMhaZn/b9IAWdCveS+G2Us9n54lGzI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=TrRnU3wnP6U+g+cqhPe6MCpQ29y2kLeevjxWjM8P9I1sanezjENkv8iSjmWLTHDlZ
	 jyBgohNuDnrLPb7lzKGyXYJ1jJoOpDfcWC/cYUFRnkIJT+aVXWQmkVH0YWGR+ZXf9h
	 e22cXi43ty2RAlP5CIherqsyuPlksyQGzIXzS+rwXOiQHoVGxas84EMI5RTcXe5MCp
	 wcrabuxm35fb6VdvLnA+WlLswgpvVzOvGjc7xKEzEniRGq+YXZ/cbgA6ZSINb7Cy6h
	 KNxputaKPfBxZVibcY+qavi+QO/Iefq7fbT20HDPzwIQ7XVe0scnt55DNBcWQYI491
	 ZnND94nJxIktQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dbf8efabdeso46334675ad.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 22:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709620409; x=1710225209;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hW0QObVw3h/AjNMhaZn/b9IAWdCveS+G2Us9n54lGzI=;
        b=RswnSHQDmylRm5gEn8pfUsMMtCql5IUI5104Oe+KDRYcvjovrW+kqWOx3Y1gOrtsB2
         uMekIoVzAaX8HVNOj2mkAAUwsBjTt9jzYHA/JVds4HnhuwfrRhrDuTsqq1qKgFj1Dl4c
         FSXfcU2/vi2/tiRf44OLeCAfLbvdvwHVXnoxITFY8Ced/GAU3Awf3+K1+jeqe6GgrONw
         Oy0KsVV9d8/9EzoLNVN6iAqK+RpG9bUe3/Flgp3+yluvlBOyej8ITz/Jup3hQxcaV1KR
         7Tlxet/KNcNS6OTHuwPNPSAx8evnPB8Lbchzax+3li11GX8ZFYBHHeRWMujrUuIDNEZh
         aJlg==
X-Gm-Message-State: AOJu0YyMTxkiGpmb6RwcKRd3LJv/dKZtrKkZGtiJnFEhkl8+O7kEJCKr
	cpIOr8RNWnS6P/+1mWv8ETSdB8gd6SjPNRErw6WiwCvmewwNFWOmaXPTeyKzuji1NRCyZUu18jB
	oJQTj2MGvK6fQ0SPrXw8RH9cbsRAOD81TDjk9Q+gGnI41RenQ/ED4BqOxDiPYqGNwN48k+1Xkgu
	Rr2A==
X-Received: by 2002:a17:903:2449:b0:1dc:b80e:5678 with SMTP id l9-20020a170903244900b001dcb80e5678mr1001281pls.23.1709620409001;
        Mon, 04 Mar 2024 22:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+WympTmYfZkLN1BGFxzHlq/Jpy0OqE0ZtIga5PjODgo/llHfGcRByulo3KA1g06nU0NmA/g==
X-Received: by 2002:a17:903:2449:b0:1dc:b80e:5678 with SMTP id l9-20020a170903244900b001dcb80e5678mr1001272pls.23.1709620408678;
        Mon, 04 Mar 2024 22:33:28 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b001dd1d7bc0f7sm2433860plb.154.2024.03.04.22.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:33:28 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 9FF8E5FFF6; Mon,  4 Mar 2024 22:33:27 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 994269FAAA;
	Mon,  4 Mar 2024 22:33:27 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org
Subject: Re: bonding: Do we need netlink events for LACP status?
In-reply-to: <ZeaSkudOInw5rjbj@Laptop-X1>
References: <ZeaSkudOInw5rjbj@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 05 Mar 2024 11:33:38 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32498.1709620407.1@famine>
Date: Mon, 04 Mar 2024 22:33:27 -0800
Message-ID: <32499.1709620407@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>A customer asked to add netlink event notifications for LACP bond state
>changes. With this, the network monitor could get the LACP state of bonding
>and port interfaces, and end user may change the down link port based
>on the current LACP state. Do you think if this is a reasonable case
>and do able? If yes, I will add it to my to do list.

	I think I'm going to need some more detail here.

	To make sure I understand, the suggestion here is to add netlink
notifications for transitions in the LACP mux state machine (ATTACHED,
COLLECTING, DISTRIBUTING, et al), correct?  If not, then what
specifically do you mean?

	Also, what does "change the down link port" mean?

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

