Return-Path: <netdev+bounces-191021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E0AB9B3B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A208B17E777
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBF239E7D;
	Fri, 16 May 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHiKT+x7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EB2376EB
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395559; cv=none; b=OWCvVGfzmEKqi00lg4SgbU9TSGf40rUR+So8CKbhYYIlHdsXGL6GqpiMN5ZdPmtQBjfRZytTioi9aDkxfs7gkX2eeR4Vd9oza/QEf3nLetblA1boNCcuRdCMVyBipwr7GxQ2iheuLKqnYvZllkNJkzf4rpf/ld58nGnG7huhWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395559; c=relaxed/simple;
	bh=3LsIdcP1+c7CpgHX3Tbpho/DjkUxvJosmatxwqBg2Kk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=j2WdQKct5ZnikP6rqzC23tMy8rDBeO5gSV292Wg4PYHkmrCTkRQ+LkEz7n7aAsU2NzVf05uS4GX1U91f1v0rjd9/TocpYMmVQzeLV93DH7tv5WjM3Iv4EJ3pnMKRZjRHd/5BCiTK8OpK7u6Sm/QKwsBQkcrpUvRF6pqU1UvELT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHiKT+x7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a36463b9cbso31009f8f.2
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395555; x=1748000355; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LsIdcP1+c7CpgHX3Tbpho/DjkUxvJosmatxwqBg2Kk=;
        b=bHiKT+x7TEQrU2YlDETfqOJe0NM+vEXMJY2lYBooAx2VqSG3yENNb341ZCAC3Z38kF
         YU3IPXLis5QNo7DBaH6nt/G6n8aonRpBjzohMkItidedxn0UpsW+eFwLutTKU9HHQtNn
         /vNOZ/+UlsFiKtQNC379uyMKuYMF/3gxi3CIybhzy8Hw8Upn5oLOOwMwWx7k+nlPaBJo
         9xmPpfWQD6mxqnL8+n6cigvAza1l+LhgZYDAnlGbFJ4puHTdqVNBbx6ZkEqwB+8T7mPn
         QS9uCkmQZPKxH6mphsS6R2e37btSyrBGLgl1i5T/Fu49DytxaTqBsMlw9i/oBxi6+Vun
         j/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395555; x=1748000355;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LsIdcP1+c7CpgHX3Tbpho/DjkUxvJosmatxwqBg2Kk=;
        b=TDZlYj01tqK73CVnDSciCKaDm54zmQsWYbYWkYRBqTn653PpVrCaNIAlsdpjbbh54K
         T/4c19oOHtvKAZcUSLDs356oQMMLulM2iS3bw5i2KVCJHJRQNQShwpxpJEnV9FrGczEX
         5WjDJwbe0phiXS2OxU+h/j8zafwmz57M9AKeIqLZg8Fs4dS43L31yQFJ9NPSc9HvZQhi
         6DyVvgoVW/0im7cKGHVRqahQJ7es9UzivMZ7lZtfBARCXJM72l3boOv5uyNfx4eAzsZx
         Cp2AOlSuEXmiHn8u+ng5XLjfwjdqooF+CjV1ZzYYLrrOWYZg4T8XbOoL1X+VY09Kq/k0
         SoRg==
X-Forwarded-Encrypted: i=1; AJvYcCWJK155Dal5bUIQowNeRrfcmZtej7zXyf6oKmnjPl8skjguE/w70En6soEO3ftrqqFFho0Pjzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3mxXfFDk3+FyFoRaE8aP29t4XbrfNdhavex2Zko3dNpbEEYb
	Xw0pu7BGdtMViFn/NuNJiNAWK/XwjZXv75U3VlfILfJ2y5Q1R7nzp7XG
X-Gm-Gg: ASbGnctmDOUssAK0m0EIqYqSqvxwrLiv39ebrJOJdwkS2/U18qKSAxzh/r2R9ALlGm7
	80/b8LM0IZysYeGGDe9bFC9TqCi382R31bYGf1E3spmDZjVo0l5GtTCx7kb5wO+Mj+xq2sQreuh
	Ico5aurG8TdK9oIt+GCNb9L6Qfvz8cYIwrIRPYq1QhJCvYtbQFqEGNNkabL7sTMt2h+cNEgmmkB
	7WgHRStC/15k3Xefr8FH36TP3JjRG84uObzKoBZZYU88JZp9RYqOaElqaiTZhe15F+BC//NJucy
	JpAaUuyIVqDniZAKH2+sCi8Q5it/jPhdLRCYGAvKtyX+DEOCLXUEHExELBIDxN7i
X-Google-Smtp-Source: AGHT+IEMfSwDG/Q8k2akooG3GkdY+cSy8EPbKcVQbfrFmV8bcE6lIOnnJuCnxZ4EYPyDL9KVvuXfzw==
X-Received: by 2002:a05:6000:4287:b0:3a0:b84d:8b4e with SMTP id ffacd0b85a97d-3a35c840d46mr3185938f8f.45.1747395555405;
        Fri, 16 May 2025 04:39:15 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5bd8asm2636363f8f.33.2025.05.16.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:15 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 5/9] tools: ynl-gen: submsg: render the structs
In-Reply-To: <20250515231650.1325372-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:46 -0700")
Date: Fri, 16 May 2025 11:31:15 +0100
Message-ID: <m2tt5kn8y4.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The easiest (or perhaps only sane) way to support submessages in C
> is to treat them as if they were nests. Build fake attributes to
> that effect in the codegen. Render the submsg as a big nest of all
> possible values.
>
> With this in place the main missing part is to hook in the switch
> which selects how to parse based on the key.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

