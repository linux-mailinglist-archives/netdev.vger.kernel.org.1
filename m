Return-Path: <netdev+bounces-198581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2DADCC2F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0406178DC9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90CA2E8881;
	Tue, 17 Jun 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPQOJoNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C82E4270;
	Tue, 17 Jun 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165202; cv=none; b=nW8Edl1G8vr1Pyg9gCFf6EJtJ2Iaz6f6EJ/A3FDoXj42y7rCmJPjAAWWHS9Mn85G3Nv2xsuGTzSpvhNxOB1ls+fQ1Q2mnJxGbUhfi2cu1Nwo8QzYXHcnM7qSeG8jVpzCPaSYEWvHBarkHlhoAIu6/CxXAb5nvqnWkmmdO1abUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165202; c=relaxed/simple;
	bh=lYCtkVyKdENR+dzqdVYy9VsqrApiz6GmggKM0FQrVSk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=e5nfr1fPKtiLsvJOHdP5NNOzrlXjht7uhUuUwqMYYpSX8IqKFT9/JGebO1t4pJFjuliUlxWmjHQNvCr1TB7EpgrchPFuYDDuGa+1E7Zghob/n1iFbAHXGdAjSAolXP9yc5yFfFtYRp62H8hPTBbZ0aRkTzlEHe1r3JwujAuDrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPQOJoNB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a365a6804eso4179128f8f.3;
        Tue, 17 Jun 2025 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165199; x=1750769999; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+1xGMAYjkvYIscDppoqoFS0dk0S9bQU0DsTqywoNvoQ=;
        b=VPQOJoNBZ/hmzaa8kpW2ZxG17UNR6fzmGgJx/f7O9pV8LuIgjMO8GtpdLC/9hFrbOU
         gcHReDWz7n9g5K2YvZ6DD6F6t6Zs7zstfeh70WDOoZ/BXXgPPl/lq7R7GwgUkAGRlItH
         Qc15GYYxipy8Xy4tBBoQdTlPDkILV9FWyN0FSDKGlVYx9wvOaPzGVxFcOEWXkPCPNbGQ
         wBWwPg3CqiF3XU9wldBAcuuiI/URmZWsjJGbx8y8xkML205X7bI/v6hDm8NaZJJDMXuR
         gXA41S1J0qiD/xpGXlD/MYEuqdlqxqHjtyYuj4/3REEw2nSN+7YwEeq1TsX/jxSrjyi/
         m3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165199; x=1750769999;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1xGMAYjkvYIscDppoqoFS0dk0S9bQU0DsTqywoNvoQ=;
        b=BdFq+p+/KlZ/UHesJrB5Tek18g9pGxYli4l6UpdAw+M3LMPR20wMVFD1gjQXE/I0/B
         d1C7GThzgbnmGWy5wiqzn5ULkrWuW7lI4V41IClknKU+79+tO2DxDNCi2KEKT+3VPe4w
         23jkYKObQAEKFBvmiuJkxIk+L6LLzAh7+IXCFn+gfSGfDhG8xDv4M2n1I1Qzph1gRkvQ
         I9+nb6GD8qDqQgvMV7KskNZ0jijsKlMqS7/j2trYzERh2GdsqxgfskSoAVHvNbq4JRg0
         jGBCh/jC9mwXxc4FFMnzhSU/7brXJ1S++ijQ4hfG7FSTdF4Qgl+snBzlu8AiNDCWs8L7
         eRWA==
X-Forwarded-Encrypted: i=1; AJvYcCUH+CmJV1G1yIVcE+/5v+9+8UvKpD9LqA4/jYYNVOm7qDPXkriuq+TxTPxoa81i5qnWy+dp6TiJ@vger.kernel.org, AJvYcCVpT6oWm6/wpagbpjLuxNGQ8hmh2cK4NcswPteQ70AnXNPj7dxEl0xC2L52AehmybJ33L1VYIJBxMTg684=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCd42GjiTLckxUoDFSFDXvHx7idUZQejDUXKsdOG6Svut5qaj
	JZ5cWcRz2glgUqPxlEkkTwjn+MQ96iti2m+KpKbyvVvKqij8TdY3jBAI
X-Gm-Gg: ASbGnctxzJizCyM+8kMzx8EXAfsufasEsvxL9smgvzYdtupD1yxuK6dIDSpkjgom1F2
	IMupta8dJxzS9j62GI6j7JPLju1Z2RmxmWXu2cDhuIVuAhVgThX8eoHfWENaKqViMNw1b/tfEr6
	gdjDK7Uf1pUnxpBwNfFl0OLW3dtN2TaUZzXuAnS+9XvgH/YoXocHB9WdN/9XHaPHRKRK0pteCiM
	MgqVT45PN+XrpxBmiqrFfBGYc8BUFgIsTlN68+mpV82z/2jkKDM86BHtrzkswEkYp+raMk+B3Lf
	Vux9lJ9hpmiNy+oOE5Gyws4p5IJQ0ZsEdjZBJObN6H9fESSWM/auISUA/Cylnn2sYLkBMWBjJds
	=
X-Google-Smtp-Source: AGHT+IEJqryb3c66QPuNLx2gZA7HOsR9NZhIMg8bp3yLVq2tmPiEQ398MZ3ApYQ2ePQKbLlR5FM2Dg==
X-Received: by 2002:a05:6000:310e:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a572370f67mr11657229f8f.14.1750165199271;
        Tue, 17 Jun 2025 05:59:59 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b47198sm13724028f8f.81.2025.06.17.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:59:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 03/15] tools: ynl_gen_rst.py: create a top-level
 reference
In-Reply-To: <4496d88c381b9f7ddce37c5a2d53156c5e8e6a17.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 11:40:59 +0100
Message-ID: <m2sejyk5vo.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<4496d88c381b9f7ddce37c5a2d53156c5e8e6a17.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Currently, rt documents are referred with:
>
> Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt-link<../../networking/netlink_spec/rt-link>`
> Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
> Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
>
> that's hard to maintain, and may break if we change the way
> rst files are generated from yaml. Better to use instead a
> reference for the netlink family.
>
> So, add a netlink-<foo> reference to all generated docs.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I would still prefer to see patches 3 and 4 merged since they are part
of the same fix.

> ---
>  tools/net/ynl/pyynl/ynl_gen_rst.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> index 0cb6348e28d3..7bfb8ceeeefc 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> @@ -314,10 +314,11 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
>  
>      # Main header
>  
> -    lines.append(rst_header())
> -
>      family = obj['name']
>  
> +    lines.append(rst_header())
> +    lines.append(rst_label("netlink-" + family))
> +
>      title = f"Family ``{family}`` netlink specification"
>      lines.append(rst_title(title))
>      lines.append(rst_paragraph(".. contents:: :depth: 3\n"))

