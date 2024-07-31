Return-Path: <netdev+bounces-114340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D389423B3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D616B213F0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 00:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5F4C80;
	Wed, 31 Jul 2024 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=krose.org header.i=@krose.org header.b="VWf6Y+1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A154C6E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384339; cv=none; b=MwkFy3WPOrRYxunDUclKO8gfNOnjQBQxgNQm+/6JcTWABDSjpzFBbC9wj11vlbd42+2fZVU7Ax6nUw77/lcQAG675zLJordefdkolldlwA+qu154nf0I2qSkWgJyMpBddUncY3sYvaJ4NitA/m4+NRi1qz47f9A+x7FfF37JfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384339; c=relaxed/simple;
	bh=HQrg0s1ifilZiL8s6hkZOtBZJ6KEvf1NBpqEbiwxw90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ujz8+MY+NmzUltNe1IXLUdz5DJxEUCMYUVhHNdizmsZ64mmSVM3/0uIMSBIlyRcsHKGmdBtzqlwqHMRGdryh87FG5WZIduowfYxPm+N3ebCkq9JICUsR6MZrcktQ+45Ysd7dBlV0OLOlRiFKOwXS9tP05ry1epzGoi9sjl7USj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=krose.org; spf=pass smtp.mailfrom=krose.org; dkim=pass (1024-bit key) header.d=krose.org header.i=@krose.org header.b=VWf6Y+1t; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=krose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krose.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so712046166b.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 17:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=krose.org; s=google; t=1722384335; x=1722989135; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQrg0s1ifilZiL8s6hkZOtBZJ6KEvf1NBpqEbiwxw90=;
        b=VWf6Y+1tcvj9QZw8jUFpoLk1hA/Z7GGfBzBJeuPNe93VbIo+69HndK7NetJ5BXygZ5
         IIu+Ks9GmhylJPjtAcmsrQ5lXo7FSjWx97YXaZpV8KYzkBy3MZAX8XtFYinIF2exhlGp
         Nk3IqcbOx3qe/BZgTEkiFbmfLOa4S+zE9fXWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384335; x=1722989135;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQrg0s1ifilZiL8s6hkZOtBZJ6KEvf1NBpqEbiwxw90=;
        b=Jff3lYR6Mdmi02PftGDd3DY53rIorfUJfTnYIhK4eyHL23BbUxXSKPafFHTES70CDV
         pIeeug8XR0YcVeTvU01eZw59VSa7cpObOcL6jV9vta/s5xWHOExt5/PoRieSlJZ+bLiQ
         UsnJnk401Sk6mwUCtKe8PAyS0vDGjKI2FtEoB0e8Fo8VFeGiP9698TOlNLiZDwiyY8H9
         Q6osvbwZSMNsvQ4etIfvvz0oXcATqX5dkOGqWBQY4PpvciKaCzYRG0JZY7bwxJcLsN3h
         xkn5jJqBgtiWoqapO0n6ItRViCqWQeyRpERyFKYno+e6KLRtYraRPxVQlbek6KI+tbNw
         qMSQ==
X-Gm-Message-State: AOJu0Yw8jMetWD1/qR+pV6ufg2/vZ7AFhWJ0h21d1comlgQOfaq/8iCP
	CRqcu27Q0E7AjQYeFDRErEJ900MVWK7hjQ8VjJZPfAkGJp5zf5GmWa59f+8V8WXXYI3aEzpFm5Y
	Hca+OVKA6YXOi8lmgOk2hM6l4jNo37xh2p/uXJ1AYsTBEkRNlzuI=
X-Google-Smtp-Source: AGHT+IE2P95KPU6/JZJxGSMzFVWysBh+5mKIBKPXVXKNHeHh3T48QC60LRIoUrKYDxV507aE7g2GvITJcvdSI3SgRkI=
X-Received: by 2002:a17:907:728c:b0:a7a:a892:8e0b with SMTP id
 a640c23a62f3a-a7d40015a95mr900593666b.19.1722384334984; Tue, 30 Jul 2024
 17:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Rose <krose@krose.org>
Date: Tue, 30 Jul 2024 20:05:23 -0400
Message-ID: <CAJU8_nUFQShNSeT52nkdKmMDx6hodgFBSN3rCVXTQ_VgqugE8w@mail.gmail.com>
Subject: IPv6 max_addresses?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

max_addresses, how does it work?

$ ip -6 addr show scope global temporary dev sfp0 | grep inet6 | wc -l
21
$ sysctl -ar 'sfp0.*max_add'
net.ipv6.conf.sfp0.max_addresses = 16

They seem to be growing without bound. What's supposed to be happening here?

Kyle

