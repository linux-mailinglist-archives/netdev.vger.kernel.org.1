Return-Path: <netdev+bounces-69396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFB84B0BC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A441C2293C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34E12C541;
	Tue,  6 Feb 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6EGXgGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AD12DDA8
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210308; cv=none; b=l5LjIkShm+la+TalJa+ZL1O5T/F9ldN5LU7LHklw/v3gq/eNUS7n6bL+lH/qhx2zRGwIi1i7iV7ylesVbPqalVYeDyiJv0rSAqlyBVTvfz+FnRDit45IqUHHJxQSWsIWrTpL0be/1UduGTApgUU5MZoKDba3iCo4PsHj70eRIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210308; c=relaxed/simple;
	bh=O5waTfhf/ktrDB/I5yUXeKgduRRSX3uNek1qzOn/AYg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=s/tYjtFpfihwKVG9jFuHGin6V49FJWEPipxUAzsePhxIVt2XwEkA4CQY7qulKft9spCJn8uRk4gjQbjAc257c4PyVuNPS9yyAdk3IRayDN69lEfyNi/kape+jW8fZlRoRJ8725hXlHoE4i4ArhmbtCfr1MqlGW8AyGJQjJ0aR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6EGXgGF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511570b2f49so335812e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 01:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707210304; x=1707815104; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5waTfhf/ktrDB/I5yUXeKgduRRSX3uNek1qzOn/AYg=;
        b=U6EGXgGFZhikQq4xi3kxVS9aCmIuep59bfRsSG2Ad+aLu8KFO7h1eLALnX1oUwbctB
         q+ash/HUxnxC9EEPGOzK2Eb1Cnfx8V6jE4NC9pu3m3w6B+HvRL344GJDqrg6TtX5RvmR
         +TofyrjpGG9a4XygpihrNd2sj+MXwANfWMGPvrjs+wTzZJmRXMzVwYvCoisYkmI91lWV
         hKaACy9aQndPnCmW7/d0YJ7g2fI0HS5jZTef+1y4U11EyZzkot8HPAIfkcDWjILZYAzP
         /G0r7IChRyua9ktmfjltaNkQtFHQNOuhYI5bw4TelBGydGMIeQrDG5VR6eQfjGutD0Gg
         yenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210304; x=1707815104;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5waTfhf/ktrDB/I5yUXeKgduRRSX3uNek1qzOn/AYg=;
        b=D8P8DNnE1l7wibCvxohfKDU6ibcNMQpiSmKSfPY1P51F6+i+XBBSMUXq/0EO8V2vEi
         OxSwheUdYOBNWb+gpqiiwqcM3nVnjRmIORF6cFk3GNwlwFNuLVdXkRSxbVs6Be5yFpZV
         UZZdJNG/IhoR4KUx/K3eQDlSCLfNfJwrDdSg2w4XMz4LJMY5Zfg6c32MStpdOWOu28yl
         7RkpgOEF8Gl0gwd8g3oIA1PBJ2it8iqU1neB9wIMVSXTrcC+D7faqz2LGHREyyZ8d3Qp
         qJRsBeDAoWyQKDjikUlGX77unkDcx+ThzIf3QRSNegv7JascV9+u5P+05/B9UbgSlWgl
         e51Q==
X-Gm-Message-State: AOJu0YwVnuuF7Iy4IfL7XTDQyglya/JZAfhYojre+jAHGr1+E1krOpiG
	CK+jTuqsWL0BWZ7+XlGI/SRsGEZO8WRoPeCtjMaj2k5diAf4Y4suZUCvgnFauxmpnt+YoLsAxsO
	VCpd2femeQYl/cgKWRf6/haYUu3U5/fspXyN52A==
X-Google-Smtp-Source: AGHT+IEL/5gfqNhBj9jVSS3TC7878/Q8bOyvd/1WzG3UxmZooPcI6nmyvCW/58DCi6yMHq+Vq5fFrw9SLqzlviH9AX0=
X-Received: by 2002:a19:8c18:0:b0:511:5ac2:eeac with SMTP id
 o24-20020a198c18000000b005115ac2eeacmr496714lfd.9.1707210304066; Tue, 06 Feb
 2024 01:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mahendra <mahendra.sp1812@gmail.com>
Date: Tue, 6 Feb 2024 14:34:01 +0530
Message-ID: <CAF6A85_nT0AyD8SW5RtYjeR3JS6j37-NqMGULJi1sz-wXXFi5A@mail.gmail.com>
Subject: USGV6 v6LC.2.2.23 test failure on version 5.10
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

We are executing IPv6 Ready Core Protocols Test Specification for
Linux kernel 5.10.201 for USGv6 certification.

Under Test v6LC.2.2.23: Processing Router Advertisement with Route
Information Option (Host Only) , there are multiple tests from A to J
category. We are facing issue with test category F which is described
as below.

Part F: PRF change in Route Information Option.

We tried introducing delay in the test case between each request to
allow processing to complete. This did not help.

Has anyone observed this behavior? is there a patch for this issue ?
Please suggest how to go about finding solution for this failure.
If I need to post this to other linux network users forums as well,
please let me know.

Thanks
Mahendra

