Return-Path: <netdev+bounces-199445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CBAE0574
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C07C17A791
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0A246BB4;
	Thu, 19 Jun 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C47NiJ8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB3238152;
	Thu, 19 Jun 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335604; cv=none; b=RnN7tZNN9SJZ0IuHiWUIMbVU4MWbM7rQ3SVxSoIwzamn4KbTp38NYjS6TbgnE3MC4PGXbnGCfrzCcU5ivniCzxyDi3meDU3/0kAlCHcmbEYodgLc/7pArXfLXXqALQGHbqk1+LeTGqxnUpQQDAUxlbhLY3H4nqNleJBJN21ZTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335604; c=relaxed/simple;
	bh=UlwbZeLMLNhVytz2MMF8Q4is5QXNpz/xiXdRg+hnNMs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=IfxkaBkw88xsMlLXmJsntdSzbtAtuPBJlHGF5LuG4ust4VDlbmWnspYGbnrH+ujyM7keuw7oIhjLD94s/KgvFgc2fP1Pp1gHphjkorAgILTDkS79FwU/akxOCJsj1UIgSN/HkCZwa3foVFulBAbNcMU1MBm72DGtNA38vL7SsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C47NiJ8n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a589d99963so745537f8f.1;
        Thu, 19 Jun 2025 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335600; x=1750940400; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqJP4+yTYhK9BQPQIOtnsPRRAOa7y/0vl+XuyGoTtX8=;
        b=C47NiJ8nTlE/HJ6OLx4dDud+iwzfLzrl118DLV4uvAIgeRTFwui1gikn2tkTi5cSbx
         c2IIpLt9Lvekkd8WxdRWFpfoIrsChH4+XYClBGgKqKNYhb96a23lR7NirHlIbZl2E+oH
         9Dpcjvjt8agnRgWEJiIdnCKnxoLSiUvpHEp7Yx60JPS+a+/oOud3qZ2acVKbbCiiVhap
         mGgf/8cML57wCIm71UNgt7qJq6ywleENqBaoPVn0XOGyOee119pxE1m0K9KbGJCzc7cA
         KIvNx+FBicNTXWQ02eSPGmGVntqnIJZUWDMaDXFGkzOexi78HiSCxMylAX7vjchKIy8a
         u15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335600; x=1750940400;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqJP4+yTYhK9BQPQIOtnsPRRAOa7y/0vl+XuyGoTtX8=;
        b=pVCxHYhlC/GloqkeUBhkVJ1GJZld5d9OYEhM+akVxcn23IYyClto9tjTi322WEH7Hu
         bgGu5UKV6uUqKtjyeP1R7w6ET9GGz1npO6fS1ive9dO7KoKkj8cN0DfvcBm2AZMb+PMx
         ugqhS0FXn+9xIv/V9ObPV2rpKSPRpPpPwI9FuA6Pz45SxWCGGscpzMhQscz9/6vhlupK
         VdM4LpQuAruHs0gzcgcKYGE54cF9l21jZWLsAMG9RaSxfQLdvutl7WGHuYJ9uMQ3y33/
         LD+4RuCFM+nhkfnoj1tDPsO5J5ED3Rvx6HmNLoanEjOQXW7wvm3X10A/TrVssPoT4xgO
         aOWg==
X-Forwarded-Encrypted: i=1; AJvYcCWIhzyIx89qigObnhRxhNCTZ0xKmQibJyEP4Rk3CGl8OdeqwvuyU3krhhAWpNNfyNpUZIaAIIFWZAeFiNE=@vger.kernel.org, AJvYcCXJB+8J8knEGKJuwUOL7R0XmR2afL1C3thhd4KXmSgvsKpoy/O9VyITQIWxtCTdXJnzCAVBeSK3@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbHrOTJBNc0dYBKFTfIyxQ4WwHMQfluyiDI/07OIc/owZkwok
	x31jzigi/Pl6slHhQizYOj0O7hNM+hovzPj3N+SxaPu/o3pJ2JCXjQBu
X-Gm-Gg: ASbGncv53D6iWnIFUU1QAhxmV7Uhf1HUbVBsGKctxAQYr0HBjttiwAFwE8mUYpAPyj/
	PvooJBqP3v2fbr4H5kdiFbCFRvCoFJyrY47Bw9skx2ynAvwY1iDU6MhamiWScBrjHgxTT+zhIit
	phGPibGMhu9M0nXPGA4cQR/sqCBScQLRsNvQ/gf/HvbOBAEfFTslJSq9griKFBrwoV/jfVj22/J
	p2JW9pEpC32RJI1IAgBjdVtlzl6nO/gIyVMmHG3qDrnUL+PoLYbTEa7EVPNnqH/pzQyZ9VPiEiD
	sMdFRAUlnhgrMW4xzhNGBZuVYS7MJdKXxLnyVW9dt/k1bpOz8s9s7nQxX4wD2NUQ1m4ihx3e
X-Google-Smtp-Source: AGHT+IFFW++i0RClDXuN5jzsKFtxPwiv+zyqlTFsPj4l45JcwpuEYcB4ySEwNMpn0lpcnf2uOPXLqg==
X-Received: by 2002:a05:6000:4702:b0:3a4:f7e3:c63c with SMTP id ffacd0b85a97d-3a571894b7bmr19742912f8f.0.1750335600402;
        Thu, 19 Jun 2025 05:20:00 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45362219d3dsm6837755e9.26.2025.06.19.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:19:59 -0700 (PDT)
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
Subject: Re: [PATCH v7 04/17] tools: ynl_gen_rst.py: Split library from
 command line tool
In-Reply-To: <4e26583ad1d8a05ba40cada4213c95120bd45efc.1750315578.git.mchehab+huawei@kernel.org>
Date: Thu, 19 Jun 2025 13:01:14 +0100
Message-ID: <m2plf0ey9h.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
	<4e26583ad1d8a05ba40cada4213c95120bd45efc.1750315578.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> +
> +    def generate_main_index_rst(self, output: str, index_dir: str) -> None:
> +        """Generate the `networking_spec/index` content and write to the file"""
> +        lines = []
> +
> +        lines.append(self.fmt.rst_header())
> +        lines.append(self.fmt.rst_label("specs"))
> +        lines.append(self.fmt.rst_title("Netlink Family Specifications"))
> +        lines.append(self.fmt.rst_toctree(1))
> +
> +        index_fname = os.path.basename(output)
> +        base, ext = os.path.splitext(index_fname)
> +
> +        if not index_dir:
> +            index_dir = os.path.dirname(output)
> +
> +        logging.debug(f"Looking for {ext} files in %s", index_dir)
> +        for filename in sorted(os.listdir(index_dir)):
> +            if not filename.endswith(ext) or filename == index_fname:
> +                continue
> +            base, ext = os.path.splitext(filename)
> +            lines.append(f"   {base}\n")
> +
> +        logging.debug("Writing an index file at %s", output)
> +
> +        return "".join(lines)

Did you miss my comment on v5 to not move this from ynl_gen_rst.py,
since it is not needed and gets removed in a later patch.

> @@ -411,7 +65,6 @@ def write_to_rstfile(content: str, filename: str) -> None:
>  
>  def generate_main_index_rst(output: str) -> None:
>      """Generate the `networking_spec/index` content and write to the file"""
> -    lines = []
>  
>      lines.append(rst_header())
>      lines.append(rst_label("specs"))
> @@ -426,7 +79,7 @@ def generate_main_index_rst(output: str) -> None:
>          lines.append(f"   {filename.replace('.rst', '')}\n")
>  
>      logging.debug("Writing an index file at %s", output)
> -    write_to_rstfile("".join(lines), output)
> +    write_to_rstfile(msg, output)

The changes leave this function broken. Bot lines and msg never get
defined.

