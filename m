Return-Path: <netdev+bounces-246115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034DCDF8F1
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B74300A9C9
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D63312809;
	Sat, 27 Dec 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdBI3Oyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE623126C6
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766834643; cv=none; b=tM87YH7DdAxYDIy28RHXvSlc0vrIc9rZIeIfU6yFdgaAa96NpKabBWt3cYF+YjIeqQ/PynETafHeEdxXR6FLYoDmy/i9ZIZn9QgfDO3tQ/GTHnsdobyLYRiLL2zEwNPde5zpjoCC3GPdVBix7boSiuagxyKQOgDdgxnGorQNuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766834643; c=relaxed/simple;
	bh=0pLwzzdz5jBOkPBZm76gC58cg6Y6DWW8MuYHFIMkYZo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=JmGWXpw06tqJReRQ9SEfoJ0SNMZKG+DosIRHieMZuiVSI0UUbGcpQo93iytV12iPowOpd9Tejwf1Kvchuu66/sC3fJTSiQThPWjtPF69QIvUUgjXLc+BVBbOcujkm57dx7mqlbLJOj7BU44XWM580WBT9uZ8trSH5H+uYqzfv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdBI3Oyn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so21488845e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766834639; x=1767439439; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pLwzzdz5jBOkPBZm76gC58cg6Y6DWW8MuYHFIMkYZo=;
        b=QdBI3OynF/aT1+Oa27ZoxcKoc1w+bbC/QDCwqxGFgqDFsH5A0OgrpcLCrZVk7UHq5P
         3d3GVl8pKxjARhfm/w+hiNgR3TDI+IyR1DfvjB5/ig7kO4I8dp6wW1piqsW7Y8s2jHIS
         tJmyTZtJt27jzOiTg/ctbTJEFLC832Gcn7Za21X99S4ndHGA3wNHbhRlG5gZpCJMGRNo
         yVuaYn/gyL5TWvHoYbdUit+Lw5idALmyUY8+P5CLeOFFpGgxF0UphrBPE0Qob0ZjwQYv
         CSW6BXn8Sh6iCmQgzZQYkgR9SGqmVe0ezpYlBDPwQFdjHo5AlP7FFqhLA5R+UhFpdAhC
         IrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766834639; x=1767439439;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pLwzzdz5jBOkPBZm76gC58cg6Y6DWW8MuYHFIMkYZo=;
        b=rtCqF6pMAzhULGImhqoT83aOzDX9vvt6O/CKyBBiljdixzUh3l5fBk+HC86q+cwet0
         pgd37+mlNymor6wNRZjsnLbJbQwMLyxbeKCmUFNN6bKkan6AAFaM6Z299cTm1BdIKwOX
         B++u1n31hlEo5F6RO+IuRGwLVKdmGtsLtZVSl1FTu889V8jOOEYOiCanlkXJl9DvZDEw
         3u6mcQn2SpBZrEbQ20TelhtdR+Dl5ZZREiwaqdbw+Ds3sObFjU/Ts3p5ohJvxvHjGFbV
         rdNNrdDds9sMKF02RrYeyC6n3BB6s7z1pY45C1gLped2d06IvFeh9/znvZpzaZHr6hwU
         g5Xg==
X-Gm-Message-State: AOJu0Yyc2MsDCjAy4P4F01MXYJCU42Nh+AXAV0fmfk4qLKEdu7joPidn
	3jjAUYJcpST7EPwR0kWgS15kEE9C10OGDkeKS2v93ityVjjB9QTWsU3JivisOMpz
X-Gm-Gg: AY/fxX56igQ6WShFNoUxwqoXtyobK0YM04kT0LvgSmgGsPazlYrefFZfKlK42ZNWm7t
	tKW4IHML4QEUoxYtCdA1IdhGP5YcbLUafuvmZ7xdbcYVv6c5yZypV/4FKn5lAzsvg8CfrYBgs3S
	SRWS+H49kWUn0/hTtILPUfN1nckF4Idzb8v46Sk3vN1pDqhnfc3jrKFcEL9EJ1u6mQfBZDiLixC
	o6xo3DVjUwuFIx09PsD9o03RI91XZPoIk4jEWrKyBFR3fUOv2IJ19ZzQ6LmT0XAnjAQru63FhJ5
	GPwG4CRjSM3noavHFCHHxKM6CeEEG33V6CQs7TLI4EJstqdsZKrdvd/EYFQmdrRzSEufhBFqs3E
	yq69JfLVFZ7K6pnP7r3iskalsVVadNkXps87ipl6gmFSXWy81BO/U3/R7r1UgnCPFSC3kKzrZu3
	LaJ94zt+W2tGVcp0H/s3seC/Ches+3GKorVFvdqQ==
X-Google-Smtp-Source: AGHT+IGVkFKdfVETcyCUoHa4xjgobZrWTt9V9bsInCzh0ZdtJz2IZqvr6CyHh16FqKsr/qDcbhTPbQ==
X-Received: by 2002:a05:600c:c041:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47d1c0360b0mr176123845e9.26.1766834639435;
        Sat, 27 Dec 2025 03:23:59 -0800 (PST)
Received: from smtpclient.apple ([114.84.104.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a40c5dsm196607425e9.6.2025.12.27.03.23.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2025 03:23:58 -0800 (PST)
From: laughing lucky <laughinglucky6@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: 
Message-Id: <34843FA4-B7E8-4E17-9707-5709254D631D@gmail.com>
Date: Sat, 27 Dec 2025 19:21:50 +0800
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Subscribe netted

