Return-Path: <netdev+bounces-205829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D6B0053D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BF0587EE0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A48272E44;
	Thu, 10 Jul 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONdHz30Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9D27056B;
	Thu, 10 Jul 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157633; cv=none; b=BG/2eht0nl5fUdJMSellFtYvMw1Y7cAWWxiudO5wLbFeGGlzsa2GNI5XeMZXvB1Ayc67Y3naepvhNpdeR7FtA00rdomnSIkrBhjYONbceOo0MlqMdTdf3Q8RzJ3iu2DrC5AwXRRSWpPKvlCA3mOW41JgchFE1UpjttQQLfe+YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157633; c=relaxed/simple;
	bh=SE9IOhUv1MNCCrAdQ80BgU7INBJblvB5g5BNAJCOdvY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=OQxwVj6vV7uksXbazaJpfMlnlQVS96c3KdRC9bkiRptVmDOPYO5NNIr/BY14C4DcVftIb8koHILSAMFg4v5Mlad5bAwAdOXc/KqXdh9CYRyZyzwp4fcrGKTDfdTfFdD91GpXAI6i22tJ2Yu3eSXyxE6d0J1YqS1Mo5Gy8INuceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONdHz30Z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1393918f8f.1;
        Thu, 10 Jul 2025 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752157629; x=1752762429; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+aeDuNjHdMlA3YEkviB2IrzxUH9ijDL9rPE1bZjJuQ=;
        b=ONdHz30Zu/d1JkWWNBbYZ8sdp/IfpVz4md4C/tYFXUrTd71qLuU1Jk5AMXrU4k04oE
         DTlWNpNjM3+jucyijIQracNSe2+PL/rbl2rFloUZ8+D4tW8egeqQ8bLOECjWjeXlSm/D
         qfm0ppxqowEZVYMafLwQnF5XEQTHpixJqViGDhfuZKs7nemEFp9GNAeIxXt1QVPnID92
         U2Ri9/2ImtLvao2W7nTnoWILXWHAqvMct624aVRKkAjkpWkrpnGP9RFPaM4GwDj0NFSd
         qu8bWoU5dM1g9/P/OvVlISkzQUP5zQHTtjalLnqBZWh0g24mY1XL7B+cgGe2WcTNbTKw
         EMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157629; x=1752762429;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+aeDuNjHdMlA3YEkviB2IrzxUH9ijDL9rPE1bZjJuQ=;
        b=hRMYuiOyF68h3ZXFd0MEZf14DUzl1Zr7uSSiPRMs2qsT7HJiEL83Jakgt4sqgmceLQ
         k23COIexOEI4t+ixaYfJBuDYthhhTXd6JcjqheZuG54v5db0FxaZLLiyGSoxYTVzRVvd
         EfNSoGegaq5FZKtlnc4CTrNK2UF/xQu+uIoQLz/ra64KpzcpVyk3HWxQBYDLCWGk/qzD
         TLFhcPLkpSA8FYPhkHR7DqBEfVBc5tcGIcihCiuudl6oWBpi8Mw471h67ikG864dl0Uv
         nnrdu4obP7Rvo5tEqLsQeHaBOxIkvItVw+1y0giGpozgkSIXxWbeZLsKiUMp8HM0lnnM
         ToGw==
X-Forwarded-Encrypted: i=1; AJvYcCVHQy7VUkApJ802sRFm4LcnbG/lEMC3I8cbv9QKmuRN58om6zUl8EZZg73jRqIQTUHLmeJDJ7Lq@vger.kernel.org, AJvYcCX6j1W3dkNKGn2V8ksDYgMzdXl2EHpM2ui5RME0EsUVLRVEyy2Rvqf+FAE96ctivuX+PK6f3pBuOaOuQfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Aesc0vQQ4QNHK0N0RAQksHOHjYukDlT8tsUUwuz2YxIm1KY8
	ISP7o7C4Lggk9tSMKTt2+7hpbfBGTuTPsom8xOWJ3ihhSVse6LWoBQCl
X-Gm-Gg: ASbGncvGW8wBI7HlJ4m7MTcDFL0Zr02kjF7U2bbf/1wmDgfUNwpKAuYkHksxIa0Agik
	A14q/FB8BhhEMz8AbGNtIwLU9ljwjEpEnqH66FSrxku+6J14ubq6zKXMAaEo6YMWVZdt3E40ta7
	gEQbhcMO2+Pd9BabhsMF5lAF1RuIph+/itr6zfLSPHb16HRdSlrV2TEXD8Ujy86rR32e8lxLrPs
	gsJkieeO474gAE0dD1MYH98QoxfYemHor+5e2RJIvgbEadJUVKBjM55mVRIneyaluZrRiOoKkgL
	OdDtjKstIzuOpuLW5XMmsnEbO7/alz/oM0M+6zaPyidUmFRSUwkHitm2aH0vZKJUCla/PIBQTPA
	=
X-Google-Smtp-Source: AGHT+IGbhb1Zio9W5HRGTNs7ZDqwVrGP0s2avBpyUCsXHGSEKkLCgpXpwSHo+05QvzlMF+IRw+s3EQ==
X-Received: by 2002:a05:6000:2283:b0:3a4:d685:3de7 with SMTP id ffacd0b85a97d-3b5e7f0efe6mr3140716f8f.8.1752157629028;
        Thu, 10 Jul 2025 07:27:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a8bc:3071:67a5:abea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2147sm2051192f8f.32.2025.07.10.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:27:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Ruben Wauters" <rubenru09@aol.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Simon Horman <horms@kernel.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v9 12/13] docs: parser_yaml.py: add support for line
 numbers from the parser
In-Reply-To: <m2zfdc5ltn.fsf@gmail.com>
Date: Thu, 10 Jul 2025 15:25:20 +0100
Message-ID: <m2ms9c5din.fsf@gmail.com>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
	<3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
	<m2zfdc5ltn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Donald Hunter <donald.hunter@gmail.com> writes:

>>              # Parse message with RSTParser
>> -            for i, line in enumerate(msg.split('\n')):
>> -                result.append(line, document.current_source, i)
>> +            lineoffset = 0;
>> +            for line in msg.split('\n'):
>> +                match = self.re_lineno.match(line)
>> +                if match:
>> +                    lineoffset = int(match.group(1))
>> +                    continue
>> +
>> +                result.append(line, document.current_source, lineoffset)
>
> I expect this would need to be source=document.current_source, offset=lineoffset

Ignore that. I see it's not kwargs. It's just the issue below.

>>              rst_parser = RSTParser()
>>              rst_parser.parse('\n'.join(result), document)
>
> But anyway this discards any line information by just concatenating the
> lines together again.

Looks to me like there's no Parser() API that works with ViewList() so
it would be necessary to directly use the docutils RSTStateMachine() for
this approach to work.

