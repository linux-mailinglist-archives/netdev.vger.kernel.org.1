Return-Path: <netdev+bounces-197466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF1AD8B67
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA854188C89E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA32E339C;
	Fri, 13 Jun 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2LzMwsh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF92E2F05;
	Fri, 13 Jun 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815739; cv=none; b=LiVr577nFECPEUQYrNOd93y0gJKVyOhTQOytFgmBNFyKQ2JIetoyT9wkZRorA43WZFSW5eqZgMm+yMIiVHQ9r6RbKmSo7XlHey/HgTY1ZKsY3tKg3odrK+DfVH+AXeidQoQ34PGZkBGIWUHoRJ+4q0+wqmBf/u2fqrQ1DSto/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815739; c=relaxed/simple;
	bh=zXGq9qaDsbHQ+3z70oVdXVkvT7TLBW8Sq21vfokbjNc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HK4DaSalqa/iFvpJfO1QgDJ13YjfmFyLVqMl9+kqWjHDdy4Ee8LrF3r0yZ4jROGB4E2ouV8TwqpS9TeylYXJDaRam8cghHLA2Cg2bjYUSqj8klUF159cNWnWifBfmFKr7Gh5OkFI3/CMf0Fk6C5QzCyilplcSDwnWXmFer3tg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2LzMwsh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so16359925e9.1;
        Fri, 13 Jun 2025 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815736; x=1750420536; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7UTlJHoMHi1drH038eVgqSVLWynDfABQdhPWNCYmpg=;
        b=D2LzMwsh12m8HP6xF7s/gdOD8pLfb9IrRMI13rFv9MCDjhZbBrk2JZihwJP1LXJEo6
         Up2Eeu324uCHuXwuUy5NB9tF64O+b0743dB0kWRRujCRY0AFg0wvd2s5gSR8zU1lqIvN
         je1k3PYiSS+EikuRji/eU9ZDO5oETOw/lIv3aLYy7C+rLIEugPKRuc3Bl1fYqDO4m59q
         0U2WYWU2lP3uxAuVDn+tVNJwjnaGFOnZaPPmJiareiqyxOtASl/jy//IncJWUXRwq776
         JYQ0LHK373YjB5chsy7ExBmyZfxW2q30ek/tYtneh0cP60df+94PjsHpHPGZWHZsmcMR
         MlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815736; x=1750420536;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7UTlJHoMHi1drH038eVgqSVLWynDfABQdhPWNCYmpg=;
        b=wkePYIVAj+iyHFmpTKLFUdKASmYrEFP+0qVyqAyLTRnzkT4d8eJXYP67a/T6QkSGVO
         65tG1cA4ykQ9Pl34Lr1SXNtt3kceDAOE/YNS4woMurAzDizHLK753uArZiXa1vR5iudb
         TjfdRXBKoaEB5OzwcU8BfAimBKrfJ8a9Z4c5hx15kMRva87E0Po5IgekKx0hNPi6Eo7I
         Ij+a1TGl23g/hOZ+zN8kRwyrtT9VoAlwUPcWdBkzqPfrmiJexsIiCr5AOwIKh2zyz11v
         ia8kGDavMqNxRoOjl0MRK1n4lJW40eh5OZxZb67hoXfYyNjznzqMO49nZmbQBI3fprRD
         1c7w==
X-Forwarded-Encrypted: i=1; AJvYcCViPSGRiA2DN1l+bOM0REKDYbVUptSfwgZMthES7ZxclQSnrNFcBtbM0gIb7oSC2M6QWhhDLi3wouAzV/I=@vger.kernel.org, AJvYcCX0Gn6gO5uTDo6d54YddL7oSLfz9ixGwNetX6i748T+9iLZ6lc6EMvNYPEYO2cj3izguCkaFkqz@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGZs5ZLV+LdIhDD/TZI/NJWMZQgdQfbGJ8JWJ6F0AuWtrwKsf
	tT83tMzJR6tb1Ta3w+UUHDh1Ze/4UUboa7Iblmc2qwFgrY62r545MJI2
X-Gm-Gg: ASbGnctJnZ6vjv0eDFTdj+6T6RvBcIzX1QRd3yP8m0pffZiAYUY34pQScyQYahcI7Su
	kOXosJLtdlWqltr8bO8qZFrAMzHmKHdyCrh0kvgRj6/wLwNFozI4tBJ0I37cKUkdLMXqwHeLJJv
	LvAGYG5e7NY+M/lNExPcBbUKshCCqrrINohzQmx37XFIIuhzld9VkpSkqq5fHZreuau8o73tIeq
	7yUCAOtGJQSiaaoJit7ncQnmqoSpuMc/+hwBrGVFRcP4lShCcP9cCIdQLS8wAnyF63e4GuBiTHI
	BTrabMwOhvFRB01aLigfjmV351/7CTgUKqO7SH9kroavoZ9WNheGHy3vCML556k5ljlMSC2UJZj
	HXufo5W4kRA==
X-Google-Smtp-Source: AGHT+IFi/nbdK2tp24U0X9KzKkQTjtsKVXLh7U3co32ExcLSRr/fke5SRM8jwCxSx2RJEy/QxZQqHQ==
X-Received: by 2002:a05:600c:5251:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-4533b28a97emr5390165e9.16.1749815735625;
        Fri, 13 Jun 2025 04:55:35 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c4e8sm50104975e9.3.2025.06.13.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:34 -0700 (PDT)
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
Subject: Re: [PATCH v2 09/12] docs: sphinx: add a parser template for yaml
 files
In-Reply-To: <39789f17215178892544ffc408a4d0d9f4017f37.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:29:34 +0100
Message-ID: <m2tt4jnald.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<39789f17215178892544ffc408a4d0d9f4017f37.1749723671.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Add a simple sphinx.Parser class meant to handle yaml files.
>
> For now, it just replaces a yaml file by a simple ReST
> code. I opted to do this way, as this patch can be used as
> basis for new file format parsers. We may use this as an
> example to parse other types of files.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/sphinx/parser_yaml.py | 63 +++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100755 Documentation/sphinx/parser_yaml.py

It's not a generic yaml parser so the file should be
netlink_doc_generator.py or something.

>
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> new file mode 100755
> index 000000000000..b3cde9cf7aac
> --- /dev/null
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -0,0 +1,63 @@
> +"""
> +Sphinx extension for processing YAML files
> +"""
> +
> +import os
> +
> +from docutils.parsers.rst import Parser as RSTParser
> +from docutils.statemachine import ViewList
> +
> +from sphinx.util import logging
> +from sphinx.parsers import Parser
> +
> +from pprint import pformat
> +
> +logger = logging.getLogger(__name__)
> +
> +class YamlParser(Parser):
> +    """Custom parser for YAML files."""

The class is only intended to be a netlink doc generator so I sugget
calling it NetlinkDocGenerator

> +
> +    supported = ('yaml', 'yml')

I don't think we need to support the .yml extension.

> +
> +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> +    def parse(self, inputstring, document):
> +        """Parse YAML and generate a document tree."""
> +
> +        self.setup_parse(inputstring, document)
> +
> +        result = ViewList()
> +
> +        try:
> +            # FIXME: Test logic to generate some ReST content
> +            basename = os.path.basename(document.current_source)
> +            title = os.path.splitext(basename)[0].replace('_', ' ').title()
> +
> +            msg = f"{title}\n"
> +            msg += "=" * len(title) + "\n\n"
> +            msg += "Something\n"
> +
> +            # Parse message with RSTParser
> +            for i, line in enumerate(msg.split('\n')):
> +                result.append(line, document.current_source, i)
> +
> +            rst_parser = RSTParser()
> +            rst_parser.parse('\n'.join(result), document)
> +
> +        except Exception as e:
> +            document.reporter.error("YAML parsing error: %s" % pformat(e))
> +
> +        self.finish_parse()
> +
> +def setup(app):
> +    """Setup function for the Sphinx extension."""
> +
> +    # Add YAML parser
> +    app.add_source_parser(YamlParser)
> +    app.add_source_suffix('.yaml', 'yaml')
> +    app.add_source_suffix('.yml', 'yaml')

No need to support the .yml extension.

> +
> +    return {
> +        'version': '1.0',
> +        'parallel_read_safe': True,
> +        'parallel_write_safe': True,
> +    }

