Return-Path: <netdev+bounces-198752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFCADDA9B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464BB165993
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9616723B610;
	Tue, 17 Jun 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPk66WYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D018991E;
	Tue, 17 Jun 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181016; cv=none; b=Pik7oMFiNwi3MDKKcRWPRzyHqPq1BA/dv9SmToK+3fj8A/HrGnTpJyLyHx9EiVa1sqhZLDXrf5ZBPD4UBV1ajITUr8ni34NLix7U4WFyJnCZ3Pdh7v9gawnZeY30Qh3dpVH8Wab+YEXak7e39B433EQTtYDNRRYkVh5sfTRiMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181016; c=relaxed/simple;
	bh=Hrcbm7dR2at0MkRPfeNTjwQ82G1ZwMmIaW0GWSsNuu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqB0VHuxEDkxAZA/kwnusmEUg9qNhc3tbw9NV4zOV9S4tBSZ7FPcEYnTv5fbvRLuyYWjwn2epmhOL73ttIgTKbPDEs6gVLv5gTTfFkQ1ZAw7G3pWVfOephFZ1gYT0owUeVrwk7yoXFws9mtzgVMdS+BDv1wzfqtKcfi6IWBCojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPk66WYa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2e8f84653c3so1196674fac.0;
        Tue, 17 Jun 2025 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750181014; x=1750785814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej9TAlXzgN0LHQcsnKzmV9b6lBqh4sRH5fw58an3btI=;
        b=RPk66WYaSqJeQGpTuQthqsVteSrztCvY0gtEMDS/gyz1l7TDk3xzEBSpdEg75F8fUL
         uC6MFOnuyPX+ncGbPAuGSop26d+gTlPlc+hHoaqGfxX/nZsSgLo/5n8Eh0bwh960IpXd
         KSofe5sG8PZjKumPivgOcaarvIujXWNtEp/UiQG/IBIMVRinlRiGisDNhW5FMkZWkZri
         eE1TxSj25pXkFLQ0h2Vn++6nIxWsRueWH2mrHkU3ZFpFkzAL3e8j2KfPTTxn9YBzXhzz
         /669dQn1UOL4ym0X9CHhhyHHFpS2PORzngireJICN9Ho2ycbkqMnKh6+PIXLf7hRrMvt
         oe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181014; x=1750785814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ej9TAlXzgN0LHQcsnKzmV9b6lBqh4sRH5fw58an3btI=;
        b=FdupSeEVQgS7Pc7UP4u4bGsps+d5p3mCnUApR4NvZH7FHP+XMXWaFDiDdAqInfDb5s
         HB2jsysfLMGuOZTsJAg8ra/2D+mdUuMSm786C3PEpJGIa5u1BTH18wh7yjU2s4F14xXf
         Au4Sequ1UM69sjhTSEmsC3wVDnb7b8b6DsrO/2C1BBZ1hdjj68HQyhQD68jlQSmMSHU1
         Bt9PEChUytTtqr1eLmZUiIHtxjU8iTKHSKrGcpoID4sGA6Q75dEaXmUXXNV7TkUzG/1i
         MLb9ne19kti8UxHwYrxzdDRkoqEdhvo/7nG7SMIgDGWfUx2Mjp0tMyBs5DiuiJK7Ijt1
         Nr3g==
X-Forwarded-Encrypted: i=1; AJvYcCUelYopJ0DiM0VpNvZG1NU6ch04B2qrocRtwFfZoMvM/69TgJnU0BMqJ32BnG4mjE9AKl8rYfApHpT4Z1I=@vger.kernel.org, AJvYcCW6SZWiZcgeYgQKBOKg8c71G7eRi+e92n0M0+/nUWRxnkYtIstUhHYtc6OCjmCeXlO6MUge82Ph@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKBalB0R6oK6AN5hXUag52+lXJZRQ7kJbD0IRz0peFvnx64jw
	E2Q/OFSilIAyB3bEGJwbPR0D+sScIeFyFQy2RAHek0JoPjOix62y2hxiRgyUJ85Be9SkZAjP/U/
	Awi1CQBK0oCWVmGvEwavcWhLM6ajQG8M=
X-Gm-Gg: ASbGncuEsRZ0/Ndsk/VmJw7pSuEnOqvQEgbcHFLGaE6F0Vtw9fVKVEIwnuOrFq4aNMG
	AQGmZNLm6vdxGkWLCJPPLnO6qleo7wm7j2I307Zd0HuNCcG09jSs1i+NVLfdG5o6z1ebqHXbq4O
	5fm7Aif4UBwSCQ8HWRFaAJR9iFT4enn7kcYUJE14w7YeX6tkPJs+2+Jphb7ugCX4Uwm3WOPKYDf
	w==
X-Google-Smtp-Source: AGHT+IGHKF0IR41tdCiQQ/QwZTYP3zh1WNnW6OvBJ5ZDaIV3FvSbKqv8iszY6CxnH5G025ZAAXULy+HPrKZVqCHkgAU=
X-Received: by 2002:a05:6871:e785:b0:2e8:7953:ece7 with SMTP id
 586e51a60fabf-2eaf08390ecmr8933677fac.24.1750181013728; Tue, 17 Jun 2025
 10:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <c407d769c9f47083e8f411c13989522e32262562.1750146719.git.mchehab+huawei@kernel.org>
 <m27c1ak0k9.fsf@gmail.com> <20250617154049.104ef6ff@sal.lan> <20250617180001.46931ba9@sal.lan>
In-Reply-To: <20250617180001.46931ba9@sal.lan>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 17 Jun 2025 18:23:22 +0100
X-Gm-Features: Ac12FXxjYAQl11Cjy04pJrUUVKxkLrmxF1LVKWdXWiav8_AOc6p_ww281gT6_58
Message-ID: <CAD4GDZzWMoxnatNXYbKOphzVZ4NyedD5FtjxF7cgB1ad-wDFWg@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] docs: sphinx: add a parser for yaml files for
 Netlink specs
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 17:00, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> >
> > (2) is cleaner and faster, but (1) is easier to implement on an
> > already-existing code.
>
> The logic below implements (1). This seems to be the easiest way for
> pyyaml. I will submit as 2 separate patches at the end of the next
> version.
>
> Please notice that I didn't check yet for the "quality" of the
> line numbers. Some tweaks could be needed later on.

Thanks for working on this. I suppose we might be able to work on an
evolution from (1) to (2) in a followup piece of work?

> Regards,
> Mauro
>
> ---
>
> From 750daebebadcd156b5fe9b516f4fae4bd42b9d2c Mon Sep 17 00:00:00 2001
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Date: Tue, 17 Jun 2025 17:54:03 +0200
> Subject: [PATCH] docs: parser_yaml.py: add support for line numbers from the
>  parser
>
> Instead of printing line numbers from the temp converted ReST
> file, get them from the original source.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index 635945e1c5ba..15c642fc0bd5 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -29,6 +29,8 @@ class YamlParser(Parser):
>
>      netlink_parser = YnlDocGenerator()
>
> +    re_lineno = re.compile(r"\.\. LINENO ([0-9]+)$")
> +
>      def do_parse(self, inputstring, document, msg):
>          """Parse YAML and generate a document tree."""
>
> @@ -38,8 +40,14 @@ class YamlParser(Parser):
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
>
>              rst_parser = RSTParser()
>              rst_parser.parse('\n'.join(result), document)
>
> From 15c1f9db30f3abdce110e19788d87f9fe1417781 Mon Sep 17 00:00:00 2001
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Date: Tue, 17 Jun 2025 17:28:04 +0200
> Subject: [PATCH] tools: netlink_yml_parser.py: add line numbers to parsed data
>
> When something goes wrong, we want Sphinx error to point to the
> right line number from the original source, not from the
> processed ReST data.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> diff --git a/tools/net/ynl/pyynl/netlink_yml_parser.py b/tools/net/ynl/pyynl/netlink_yml_parser.py
> index 866551726723..a9d8ab6f2639 100755
> --- a/tools/net/ynl/pyynl/netlink_yml_parser.py
> +++ b/tools/net/ynl/pyynl/netlink_yml_parser.py
> @@ -20,6 +20,16 @@
>  from typing import Any, Dict, List
>  import yaml
>
> +LINE_STR = '__lineno__'
> +
> +class NumberedSafeLoader(yaml.SafeLoader):
> +    """Override the SafeLoader class to add line number to parsed data"""
> +
> +    def construct_mapping(self, node):
> +        mapping = super().construct_mapping(node)
> +        mapping[LINE_STR] = node.start_mark.line
> +
> +        return mapping
>
>  class RstFormatters:
>      """RST Formatters"""
> @@ -127,6 +137,11 @@ class RstFormatters:
>          """Return a formatted label"""
>          return f".. _{title}:\n\n"
>
> +    @staticmethod
> +    def rst_lineno(lineno: int) -> str:
> +        """Return a lineno comment"""
> +        return f".. LINENO {lineno}\n"
> +
>  class YnlDocGenerator:
>      """YAML Netlink specs Parser"""
>
> @@ -144,6 +159,9 @@ class YnlDocGenerator:
>          """Parse 'do' section and return a formatted string"""
>          lines = []
>          for key in do_dict.keys():
> +            if key == LINE_STR:
> +                lines.append(self.fmt.rst_lineno(do_dict[key]))
> +                continue
>              lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level + 1))
>              if key in ['request', 'reply']:
>                  lines.append(self.parse_do_attributes(do_dict[key], level + 1) + "\n")
> @@ -174,6 +192,10 @@ class YnlDocGenerator:
>              lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
>
>              for key in operation.keys():
> +                if key == LINE_STR:
> +                    lines.append(self.fmt.rst_lineno(operation[key]))
> +                    continue
> +
>                  if key in preprocessed:
>                      # Skip the special fields
>                      continue
> @@ -233,6 +255,9 @@ class YnlDocGenerator:
>          for definition in defs:
>              lines.append(self.fmt.rst_section(namespace, 'definition', definition["name"]))
>              for k in definition.keys():
> +                if k == LINE_STR:
> +                    lines.append(self.fmt.rst_lineno(definition[k]))
> +                    continue
>                  if k in preprocessed + ignored:
>                      continue
>                  lines.append(self.fmt.rst_fields(k, self.fmt.sanitize(definition[k]), 0))
> @@ -268,6 +293,9 @@ class YnlDocGenerator:
>                  lines.append(self.fmt.rst_subsubsection(attr_line))
>
>                  for k in attr.keys():
> +                    if k == LINE_STR:
> +                        lines.append(self.fmt.rst_lineno(attr[k]))
> +                        continue
>                      if k in preprocessed + ignored:
>                          continue
>                      if k in linkable:
> @@ -306,6 +334,8 @@ class YnlDocGenerator:
>          lines = []
>
>          # Main header
> +        lineno = obj.get('__lineno__', 0)
> +        lines.append(self.fmt.rst_lineno(lineno))
>
>          family = obj['name']
>
> @@ -354,7 +384,7 @@ class YnlDocGenerator:
>      def parse_yaml_file(self, filename: str) -> str:
>          """Transform the YAML specified by filename into an RST-formatted string"""
>          with open(filename, "r", encoding="utf-8") as spec_file:
> -            yaml_data = yaml.safe_load(spec_file)
> -            content = self.parse_yaml(yaml_data)
> +            numbered_yaml = yaml.load(spec_file, Loader=NumberedSafeLoader)
> +            content = self.parse_yaml(numbered_yaml)
>
>          return content
>

