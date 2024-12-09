Return-Path: <netdev+bounces-150165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A79E9585
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C031665AC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A822D4D4;
	Mon,  9 Dec 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LosTPuFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70722A1FD;
	Mon,  9 Dec 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749026; cv=none; b=iZ8Xe0nU3DyREZMUX+UpziCjUqyfvYlvfvcNWNwKR+kFwycr6iQ2VUV5J+T/RB3gjIOdKLLFKG1IGPshCbT8UfO9aO2HTRNM5p7GgXBsbQ+j7UveX1OlRWHUpci4YvfkUevMmx3D/Lz1J2R0ZNJ/M1fl0+xB5E2CHNOXc+CnAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749026; c=relaxed/simple;
	bh=egc2X+L5ugiYVqY1V6DB6F3T5HH8ETSfkFKie/g4Pfo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jteGHlHfbyec13OjolOsvtbeRPjPkR6tsDW57vA9/8/gm0ElkC820j0B/JLfDOFBqTSxzUdIG41N4W9xja4gu+XAl0c++2m3i0YKVxpZpujfnOrYpwYY8fsHrFRmupwP1xaBaw6MwMjb+H9K+Ksy9MdN3Fkh7Xy8x4wcvpnI+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LosTPuFP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6eff0f3306fso16413307b3.2;
        Mon, 09 Dec 2024 04:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749023; x=1734353823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egc2X+L5ugiYVqY1V6DB6F3T5HH8ETSfkFKie/g4Pfo=;
        b=LosTPuFPLYDh3ldYFUYTJjj7ehxWv2GBsWH9+zYWNFWYnsdSEK5jLFB9jjOXvJ2I0Z
         nrj11HaxxnzNM+Ca4WIpPWZdFAPVascZpS0prVCc49ogM0ns0Y3REnKKXGYybL3RkIvK
         612MJeXMWq6ZalsHIOM/bSgnHffeYTUR7P6RsDB1YnUgfqSfmmvw5c1RJFDR5dv8k6uI
         v9TbKmR8lDIWUBlLjx24s3/jtGbYTomAP+J2DTCFfe+NiYYUoiLdzzGSzbh51VhRJqwI
         mDLzLn9c99AN66OzRJQsAUsCSmz1kQGkihqOJsJLJmKXDxLJwzrI6aHOVnk+zCoTbd1n
         zo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749023; x=1734353823;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egc2X+L5ugiYVqY1V6DB6F3T5HH8ETSfkFKie/g4Pfo=;
        b=G6jLXdgEGvQJqWV8QQluEfF7GnlfO3vXu6a1gXR85qJxAhgU5ggKEqMbVvFfeYWLS2
         D4d81olZhfbBjbgwmuW1Yg0mL1fRwf2a7ZJKCAnbzSrU1Q0F+0R8eUNHdEz1RQO2a8ym
         SHTexBYNVdidDIQTGJZWEviUIMB5uLdIJxMKBe0bDnX/tIcS9J2lIPSAvMbr92eqTa4c
         a4VL8F/JY/94cZ60EBJSovCZB1+2NUjkVy/zhYy8be1d6sSrDTchU3RpBDWHGg0oiRuY
         byQU93WRJMp9KPCbxDtg5OT9psyidAX8TohFEU7hn/qtUgH30Zmrn+GzZOo8CU62hiFV
         8e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX2AbnkdyJDyVdbX14ZL84B0XStjyZhl+R2dKRmxVN5wT9/H38JkLLzJ+dJ0AlS5hU3T8K3t4JZWHXpmY=@vger.kernel.org, AJvYcCWM4nlaVbOt6MfZEVQiYl5OMydOhRFGXLydQh8FiK9I41vxrWokE2SZtj+C9Hed+qzUESOs9Bq6@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0a6IJUccNqPi93MJHiozgiqQ8vBhshspbB3pc3GOv+201Kds
	+mlBmENztL9fPix7gDsxSmmf+KUQN2YyhLPh8KRUaqcQno4Oh4Nyluq/0hENTfwmCyFYWGzZOXd
	fZWwzu6ZmO0N/PmeL07OI3qklbQ==
X-Gm-Gg: ASbGnctzhkObe9u2gJ5f2ITjwth0u3It//mclAX1tC05zOJX2gfMkJD2ARYJJxVvqWk
	Vc/e1RdfgCWg5RJ8SUw/Q6Vr3p2RdvV3yYUOBhbk5x28=
X-Google-Smtp-Source: AGHT+IGU+Lv4rziuWGS9vh8kNFbsAMSW3HQZxI+jdzRn7hqAd+jkiu4ue3XSEAsgOd+dmTelvW7dDUpUrDtSFxH1SsE=
X-Received: by 2002:a81:ad1c:0:b0:6ef:6f24:d080 with SMTP id
 00721157ae682-6f022e59332mr3204757b3.7.1733749023687; Mon, 09 Dec 2024
 04:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Mon, 9 Dec 2024 12:56:52 +0000
Message-ID: <CALjTZvYKHWrD5m+RXimjxODvpFPw7Cq_EOEuzRi1PZT9_JxF+g@mail.gmail.com>
Subject: [REGRESSION] tg3 is broken since 6.13-rc1
To: pavan.chebbi@broadcom.com, mchan@broadcom.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

Commit 614f4d166eeeb9bd709b0ad29552f691c0f45776 "tg3: Set coherent DMA
mask bits to 31 for BCM57766 chipsets" broke wired Ethernet on my late
2012 Mac Mini, as the device fails to allocate 64-bit DMA. Reverting
the aforementioned commit fixes the issue.

Kind regards,
Rui Salvaterra

