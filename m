Return-Path: <netdev+bounces-115487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5E94695C
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 13:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E13CB20D43
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254613699B;
	Sat,  3 Aug 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="V5CAx7T2"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128ADD53B
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683194; cv=pass; b=Ts7DH1rQ4bPcpEf1I4oGGsI0YtrrK3P56FlbkKRlom/O8rjokNM3/xTWYZk74kV+68wK1ydpYG2n14bchvQZMg/UN6KJDlm/Mc8BcTWFmfN0UcVVQ0QBxwpHha6OlzQCdaCEL2GrBJgWGhL6W46HuGWtqjJNRBcvA/uy2A5MYAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683194; c=relaxed/simple;
	bh=1wPl1b4f38KYOqA7vGEuJH8DmUfZfnZIjZRm0apTYSQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TpMzCrczay2y0aAcRetV4998UidaKKhIWlzPJDYhc5NDOMeH7i6X86ClMLwePtI42JUYHCi5CAFusiLlvb93yqV2q2g3AvaOkzg+rC6Ro0wt1/YltPXmJ0dZ9PNv/t7uH56RnyUW+RRhmSi08xkwEHxBiNgnQ4LORJh8Y+KARfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=V5CAx7T2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martin-eric.racine)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Wbfyl5mYpzyS6
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 14:06:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1722683183; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1wPl1b4f38KYOqA7vGEuJH8DmUfZfnZIjZRm0apTYSQ=;
	b=V5CAx7T2uwQu44GTLCUVX4atwcshNIoRFdBvCD0EySqj4aHQ4eK86ScDBLHaCW/Gh/WDqz
	+L/H4ze4MU1+c/rngUl5ii98Xt9ax9dUwlKE+aAxHBa1zai8vW67HYYVBZ4F3UeCcdUWUW
	tQkbX3ltTRHcZpSRpuXLlGpD/0lVBVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1722683183;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1wPl1b4f38KYOqA7vGEuJH8DmUfZfnZIjZRm0apTYSQ=;
	b=uXCWbqR5uhSeuuOUXDURvKbBY5adhx5ODxe/gHFEncks0qAs3CmucjKN21CflhGQyS59Yg
	O+yjn/pxCrjg2v11Zu6n3lpVy1CKdLbUeGR5yF9wsQ+uf3+Qz4TwZ4iJMu8eXL1mszfQHS
	FSobmHgxnCe6HxCj638iT+wZqE1SRBM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1722683183; a=rsa-sha256; cv=none;
	b=ioOLr+5w6sN6F4jo5zk4bAHX64dpJmmBUE2034Iim9nxUBqzL+sELYHNW68MeytiMmemYO
	qJgducSbKds1CrgjPJIsl3gs2EyRzdEZ1zJR9nkD/yKgThwnp9VhWekVW86CXd/LMg7vhU
	ZXCpDh6QzHgFoYjxSqQIVqvbJARGOTI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=martin-eric.racine smtp.mailfrom=martin-eric.racine@iki.fi
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so22815905e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 04:06:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrdZmkWrGT7KCEQImjeWGnaI4jf1dLWHX/yxuNG8Cj3EMKTSoq
	8csJsk4xajjjEwbn7KMcGcHk0BRp1cmd1gyISFbE0COoZbcE1iijY4t/Q8GVIG6PcW1s3jNHcOh
	cFROLMWi9gdRKpE2hNPAgByyFjkQ=
X-Google-Smtp-Source: AGHT+IFgIwIyh9qc9H+qkoTiZ80p2lqgb6ZiCaPIyZKAPFKl5h1GkAEp95gbCtDfHwz1fm8tsR2KWaA7G4RklNrEjyc=
X-Received: by 2002:a05:600c:190e:b0:426:6327:5a16 with SMTP id
 5b1f17b1804b1-428e69f6157mr40006875e9.18.1722683183294; Sat, 03 Aug 2024
 04:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: martin-eric.racine@iki.fi
From: =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Date: Sat, 3 Aug 2024 14:06:11 +0300
X-Gmail-Original-Message-ID: <CAPZXPQeO6BAznbh2+EyxTXLjcdqMe1yrGbPweRiVSy6zLnaErg@mail.gmail.com>
Message-ID: <CAPZXPQeO6BAznbh2+EyxTXLjcdqMe1yrGbPweRiVSy6zLnaErg@mail.gmail.com>
Subject: [iwlegacy] kernel oops
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

As reported a while back at
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1062421) against
kernel 6.5 (still present on kernel 6.9.12), iwlegacy ooopses on
iwl4965 hardware.

The bug report contains a lot of auto-collected information. Please
ping me if anything else is needed.

Thanks!
Martin-=C3=89ric

