Return-Path: <netdev+bounces-227162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DBBA95A2
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F967A7BC0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DAB3074B7;
	Mon, 29 Sep 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTh4f9SY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447E2F9C2D
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152585; cv=none; b=FiBoP7ezf+X/OWeHhmiEw33SV/wKVO3qQs7YocEKl+RxRP27fEbRButvqDLJB2pgDaZW1UAIn+BUobGCs+ylkxUBULxRmxuKtNfDJwtpfk6TQfHzq4L/bXOIwHSTL55reOiznbrK73Zmegfc78/XcbH7BeeHcitLQ7c6EuaCkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152585; c=relaxed/simple;
	bh=FNcNUwKNlqip7JmqQyQ2rnMMEvDy+QAhgJzQeINlxpI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q6TygZiiBTMDnkHaiwIrlcZlBEmfuGPq7TIm5olK/cf7xrRinxBb7VjDYtQNAQ4t8kdII9cXEVxoUwRI9Qvv4VH+Mzo/NBb/kHd6MsWLRj5ko2k6pUi13ZoyUTb9IVXHgWQbf0Sp03Aw7KnfOC8vQEacRTGyxrG5F14ViECJqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTh4f9SY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso195082766b.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759152582; x=1759757382; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VxXcI+wc48WXQveru4/8fmaHTPhTTTPm7z/XISsZLQ=;
        b=QTh4f9SYQvW+KQRXh22jsDKsrh7tNFKxIg5N+8uXTF0jIPitLKc+6N5km6t6bXHPry
         3av2TTxb0ZaBJEQpbuheeYcZ+3smZbJo/wBwdEpYCQJ5UKI+HaSXxCveYBrnO9bDa8wn
         1NJ7xoMDMHpvQ9dbOHRywzuJ1LJQHDi8HZ6m6VUCzD3JSvNrhQDzgv3zqW/NPEBsxzBI
         GITuJDQhkLoMEHot0UshMmWFQFnHHRsUt3oq1CZSrdk+e2GJ5fzobaItxCE05RtkayDW
         YH1t93dxBbLtC0ICpkCnaIAwe6gkgCWtQ8Ql7+jDftK6MoshaXk9gAn4BqK01bjPAtUW
         URKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759152582; x=1759757382;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VxXcI+wc48WXQveru4/8fmaHTPhTTTPm7z/XISsZLQ=;
        b=nL7FaBiDcz7EHziFR8TGpdjCX1LWN0XypySsZur+Lu7bfy4oPcaS3JxIObhSSJK0ai
         eNRxNTihwCGqkfmSJERPmbznWKm0DaTGIZ2BkUxwdvtmhknE51QHBnewQlRq8pnyMXE9
         Ezfx2fktMo5i6sk6Czc0oMmtwXeGKgk+a/m/AtfI9xVoqwqZ7cz/cGFIyCxjaUV9Eh06
         zesrus11XLUKBYraK+2t0RMxjkGCfqlZ9ycAuSTDmpWE1ZHydLJ1bzHPYWk7+APq2XhM
         0ChD2OyjqOPO/WhCk/JviUsVlajng0vuqgy6ji8NznRaMoBOJGZUHKtMb1KUfwgfNIcr
         cj0w==
X-Gm-Message-State: AOJu0YzJ3l9OKpL3oYMXcQI25YgC9LcBEPC6MCb/hgKpYzuev99UfXoc
	aDVEEDjbcDZNK0e6ZYg7wxnuZ8zRWf/cJbRvOVVP7bL11dY50CNovZyPFkjfVFAKn/sVnVHWjX8
	n/eHqX3ES7APFcsBv91/EYs5QM5M0FIOZjn1nTMs=
X-Gm-Gg: ASbGncsg5lvEyGSUSDeJ1n8kUDv9u67l0Uw97lvfOx8uCWY0lFTBincXT5W5YwpvrUa
	H9bWU624Dyh/pAI4wDy5Bzu/53xPsHSRuL3BgWO4acZ7DyGlqIwZR6NcZjKa/BiNuTEjvRDm0/v
	9zIVZ2HihMFvMXCX/GzNd1leN7nGkl8N/TuztbtSTlAEBWLW/9HgHLjAM1x1wcvw3acrDz8T7bP
	Bgsjww=
X-Google-Smtp-Source: AGHT+IEc+xsYmSCjPFKHMTQtI/yZgJEnGz27skBdJVSm3pGSFLGrAlJ1xYq38S8BsXLbnVwGF/zLpYBJYLfSG1X4eaY=
X-Received: by 2002:a17:907:8686:b0:b04:25ae:6c76 with SMTP id
 a640c23a62f3a-b34bef95bb7mr1649864166b.47.1759152582158; Mon, 29 Sep 2025
 06:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Lev R. Oshvang" <levonshe@gmail.com>
Date: Mon, 29 Sep 2025 16:29:30 +0300
X-Gm-Features: AS18NWA3W8oXaooqIB5rZNgXcCcXcoUffjbZd1x8dRBzCGbb52ROGMSQd4wPvVU
Message-ID: <CAP22eLEocTn8KQD9pQ9aDM6rxc-5eAA0P6RdxEzpX5e5X76CVw@mail.gmail.com>
Subject: Help : IPSEC and cellular modem produce corrupted SEC packet
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi list,
We had some strange problem : Linux 6.12.16 , ARM64 armada-3720 IPSEC
in tunnel mode.
Userspace is strongswan.
It works ok for wired transmission and also for cellular on kernel 4.19
 SEC layer looks OK in tcpdump of wwan0.
We had offload EP97 engine, driver crypto-safexcel is loaded but ipsec
is not configured to make use of it
But receiver got corrupted SEC layer packets
We tried several cellular modems , same  problem
So the problem I conclude is in kernel

Now the MAGIC
On a hunch I disabled   INET_ESP_OFFLOAD and XFRM_OFFLOAD  in kernel config .
It fixed the problem.
Why ?

I am far from expert in kernel networking, not even close. Can u
please advice me in what direction I should dig ?

Br.
Lev

