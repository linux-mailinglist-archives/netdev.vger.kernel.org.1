Return-Path: <netdev+bounces-205759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16967B00087
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625A95A5420
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B3A2E7182;
	Thu, 10 Jul 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSmWfrnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C02D97A6;
	Thu, 10 Jul 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146863; cv=none; b=bH1cSwn1w3RJs9Z6FXr9DmgM8Pc1utjIa6YnYTRv2FMCrFMaKpXKMImGCi1YymTJbm/rhAYdoX2zv23TlDUIoQpKGO0l7MU8Yn/q1TTnF6n8WcgSLRktPGNUN+alfcJyg1Dky8V8FXnPeqkVnVW8B9oAx7C4rMWw85ckiSamGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146863; c=relaxed/simple;
	bh=KjSzvJUpxXfbbJMn+GnW97GcF7y9pkc6qt0xEvGgaAI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PSriA/5/w6yx5IGmbvX2fBwN04ezcaw+8IWoMV8N+dyXmqFA0ddnV4Ptdux2HdiKfmO0jzs+8Y0rOW8ZtNxN/rj0X6JQXxBE5lFbKm4zRerD4ZzgxkyuV/4TS+GpaD4lv7dvR/O1GaKOSaTwL5ZFq7eTquXvrzQBF/fBnuCY6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSmWfrnF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso714582f8f.1;
        Thu, 10 Jul 2025 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752146860; x=1752751660; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IR5AJVT4G5WLtAAqgPLSimQyStJGWsVwlw9CufaXOaE=;
        b=VSmWfrnFYWAbmFVf+0lei1w04K/mJr/U5SK9QC99vbxrgsXO8kACipVIm3sG7izQKl
         Q7SN4bQQFTB7cbT7MOeb8BhyDWlo4zptzmdLmo3HyeKhXH1Pok3pYaFH0VQhXhLN8Q/d
         2mGFa2Ebzlbmbvrsq3wMzqteAoWV5TLHXiO12HwyUCs335xhHGa0KkT42MDF0x16Yr6n
         vDBjYCiw3+jTG6yNCTYfuujFeK94WSC/fMv3ZjPOr1XPrxi2OEkQVXGK4QAw2LAx5oEX
         eqyrLQqJY/fSJRWnkAhjwae9gY9u628WLtGDnH/G5uxCX3kBzUuWVI7fwA6K8Wxp/Rvr
         G1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146860; x=1752751660;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR5AJVT4G5WLtAAqgPLSimQyStJGWsVwlw9CufaXOaE=;
        b=m6levqJx884kofs/dYTbVUYerkR7+EhQMpnkEyazfDrOpz1pQ8uNVPDZKMriD2wM7L
         LdABE1YebZxfuy0JqI1YiLTmgSwoPP4ChJKN2nszttbYki0kHbT2lHlo3eGMd9KkxHdn
         33Jl+glJrVO8zeiq31vopayuegmR3ti9tv9qXY522QKsQmHL3tuUNXNvOQNV+B4cfzoX
         XrVboceqRHaXx/Wnm2a39E1XAi5Zrocc3FzdB8BC61/HYUAd+bLfmbDVp70Dzd2QX3HJ
         8HhuRHh6/WY06TN+VUDrZssMPUJijmn6g03tSYdfWXC9KSteZvGdycmK3lXnfs73/AsL
         wKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK22uG2QpxSfdFMytGTlV65KV/+l/3EsaalNBnap/BR8oyQIe+7cXS1Yt1VanTnBQSiNiSIt2i@vger.kernel.org, AJvYcCWruDomNowC0qVneIGRuuuYHDcJ3dq9uws3pKZcsJWxC9A0NRyfoSZZT+gu4QDG3QLRqkElaJcv4bTb0TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGeIuTRG0YX4/65JPOPDs1ka2mhq18+qoMtgXKpSUp1iZk9MC
	dYKQHVOppQ2eOhYM87y8STDt4+PtTaRwmtTtHi+YHnZZSsrfdK3H/f+G
X-Gm-Gg: ASbGncvxm/XOqPbApJXZ5UTsU8vSjK4jFm1SPIK4IfkAyFjOvGtlJh9YW4SOcq2+L+5
	jG/B/K3AjxWZlAoJVmWUQmtTTlnFMAeHHXBDpFCB98XGmc76a9E2CUu40y5X8BHnQys7e7y4aur
	Bl2uO3dUWB/J+0QLwRxfweN0g0SkjCspb7a/7GyP3kYQbGsONRiSbRQcAYu9VVHppf4d/SO5PYM
	cjWxtKVtXH0zToyZ/0o8NDzSNyYw1JrFsuBC5ZOX5bKDGYtN1+J9RY4MQxvyyuJZQBTdebLmpUH
	fW34r/OWXHxFUTrSx+4igMgUdpNBOr+1eO/7Gkkrh4LbcgU66gxv1q3qyzj1A+xIWb3+jm0Vtvk
	=
X-Google-Smtp-Source: AGHT+IGJxYQYyVxwJGUcleyu2QUatvGZlx5j2drpe8o9TCCtxQrleJg0cqNcOTkJRlgizlSSl5qgwQ==
X-Received: by 2002:a05:6000:43d5:b0:3b5:e2ca:1c2 with SMTP id ffacd0b85a97d-3b5e788d43cmr2498398f8f.2.1752146859857;
        Thu, 10 Jul 2025 04:27:39 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a8bc:3071:67a5:abea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd474a9csm17122225e9.16.2025.07.10.04.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:27:39 -0700 (PDT)
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
In-Reply-To: <3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
Date: Thu, 10 Jul 2025 12:25:56 +0100
Message-ID: <m2zfdc5ltn.fsf@gmail.com>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
	<3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Instead of printing line numbers from the temp converted ReST
> file, get them from the original source.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This doesn't seem to work. This is what I get when I change line 14 of
rt-neigh.yaml

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index e9cba164e3d1..937d2563f151 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -11,6 +11,7 @@ doc:
 definitions:
   -
     name: ndmsg
+    doc: ".. bogus::"
     type: struct
     members:
       -

/home/donaldh/docs-next/Documentation/netlink/specs/rt-neigh.yaml:165: ERROR: Unknown directive type "bogus".

.. bogus:: [docutils]


> ---
>  Documentation/sphinx/parser_yaml.py      | 12 ++++++++++--
>  tools/net/ynl/pyynl/lib/doc_generator.py | 16 ++++++++++++----
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index fa2e6da17617..8288e2ff7c7c 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -54,6 +54,8 @@ class YamlParser(Parser):
>  
>      netlink_parser = YnlDocGenerator()
>  
> +    re_lineno = re.compile(r"\.\. LINENO ([0-9]+)$")
> +
>      def rst_parse(self, inputstring, document, msg):
>          """
>          Receives a ReST content that was previously converted by the
> @@ -66,8 +68,14 @@ class YamlParser(Parser):
>  
>          try:
>              # Parse message with RSTParser
> -            for i, line in enumerate(msg.split('\n')):
> -                result.append(line, document.current_source, i)
> +            lineoffset = 0;
> +            for line in msg.split('\n'):
> +                match = self.re_lineno.match(line)
> +                if match:
> +                    lineoffset = int(match.group(1))
> +                    continue
> +
> +                result.append(line, document.current_source, lineoffset)

I expect this would need to be source=document.current_source, offset=lineoffset

>  
>              rst_parser = RSTParser()
>              rst_parser.parse('\n'.join(result), document)

But anyway this discards any line information by just concatenating the
lines together again.

> diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
> index 658759a527a6..403abf1a2eda 100644
> --- a/tools/net/ynl/pyynl/lib/doc_generator.py
> +++ b/tools/net/ynl/pyynl/lib/doc_generator.py
> @@ -158,9 +158,11 @@ class YnlDocGenerator:
>      def parse_do(self, do_dict: Dict[str, Any], level: int = 0) -> str:
>          """Parse 'do' section and return a formatted string"""
>          lines = []
> +        if LINE_STR in do_dict:
> +            lines.append(self.fmt.rst_lineno(do_dict[LINE_STR]))
> +
>          for key in do_dict.keys():
>              if key == LINE_STR:
> -                lines.append(self.fmt.rst_lineno(do_dict[key]))
>                  continue
>              lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level + 1))
>              if key in ['request', 'reply']:
> @@ -187,13 +189,15 @@ class YnlDocGenerator:
>          lines = []
>  
>          for operation in operations:
> +            if LINE_STR in operation:
> +                lines.append(self.fmt.rst_lineno(operation[LINE_STR]))
> +
>              lines.append(self.fmt.rst_section(namespace, 'operation',
>                                                operation["name"]))
>              lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
>  
>              for key in operation.keys():
>                  if key == LINE_STR:
> -                    lines.append(self.fmt.rst_lineno(operation[key]))
>                      continue
>  
>                  if key in preprocessed:
> @@ -253,10 +257,12 @@ class YnlDocGenerator:
>          lines = []
>  
>          for definition in defs:
> +            if LINE_STR in definition:
> +                lines.append(self.fmt.rst_lineno(definition[LINE_STR]))
> +
>              lines.append(self.fmt.rst_section(namespace, 'definition', definition["name"]))
>              for k in definition.keys():
>                  if k == LINE_STR:
> -                    lines.append(self.fmt.rst_lineno(definition[k]))
>                      continue
>                  if k in preprocessed + ignored:
>                      continue
> @@ -284,6 +290,9 @@ class YnlDocGenerator:
>              lines.append(self.fmt.rst_section(namespace, 'attribute-set',
>                                                entry["name"]))
>              for attr in entry["attributes"]:
> +                if LINE_STR in attr:
> +                    lines.append(self.fmt.rst_lineno(attr[LINE_STR]))
> +
>                  type_ = attr.get("type")
>                  attr_line = attr["name"]
>                  if type_:
> @@ -294,7 +303,6 @@ class YnlDocGenerator:
>  
>                  for k in attr.keys():
>                      if k == LINE_STR:
> -                        lines.append(self.fmt.rst_lineno(attr[k]))
>                          continue
>                      if k in preprocessed + ignored:
>                          continue

