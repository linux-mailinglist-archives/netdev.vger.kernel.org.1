Return-Path: <netdev+bounces-197467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F6AD8B7B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625D93A9E5B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414F2E6D02;
	Fri, 13 Jun 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZyewTbF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEF2E62C5;
	Fri, 13 Jun 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815742; cv=none; b=dnvM/RyGnamYZ3XqOnHM7NB90892WHsL6LdCuAPgQOHrIp/qNzJ3Q1ZJPYYpC8ji6o/qkzTIFrwJxU/PS0kYaH48qQZJrC8yXjvFCLVm0S3wrCq3HGVnhyGo0MXQSqq0n20qKiRN4xDeH+essdLkJb4XQiLXdfKgH5sSHtwHXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815742; c=relaxed/simple;
	bh=d54+gSW1JK4j62Cxqb5brtnTXHHA9kuB6ewvEvemkwE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UeXvrfcdSWe+DdJtW5ODCinnmjJUjt+8vQxZX8mpkYuruf4zMCzjI6tndialZn+HZy0uIovd4lKsp1+ZTzIcPJGKaXyv5LPj+438keq8h5ieRbxVepchYF245yuqF1NOgtdCSNVxPDsK1gYxNQ9ox1JFZHv7jfMpVWgMuzoOCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZyewTbF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so16360525e9.1;
        Fri, 13 Jun 2025 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815739; x=1750420539; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQWoVNWcriJachxlqnlzulKdD48PUrSHgzzEoQPD1HE=;
        b=TZyewTbFiLOJd4H88+KOnyA97vn5jI9VQ7dnAfDTLhRxIhy3zesHE3ALc+elPztYJ/
         1bTQFuLbrGMDB3ZY+0Pwc1VMmFgJIGm0qRY7CcCoDqCFUb2/YIFOQODlJDMh61sZxkxp
         ng2ZpsFD8HCheGDX1Ye5XkPBC4w368L4gMXo7VH4k9/2+oXAJZoAVq1PVa4cGY6BgAnW
         jj7ZvniWEpNe+dssK7eQYdcDcd64IaTB490/OruAYHdO6GCkvhwAvtSFBkG0QUETO6hP
         H9Za+cQgOJYbF7451ocP9eXP0shJDmTuvHvON2yTCSVWqB1s6VwMRZeMkBwDuR77+mgx
         TmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815739; x=1750420539;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQWoVNWcriJachxlqnlzulKdD48PUrSHgzzEoQPD1HE=;
        b=kHTS96yif4QjIahabKOGc5gUOaAXIYTM7tzZf3x/do+pMPHtNCYMpfu8JE8Kt1AJc4
         AoUws7S5ehd/l8pXMSoNfk85QiyNjwo5vcXzrayI5Zjy5lAzVHJ+8vXo7UHwal8DP9nc
         77skcSk4OfN6XAbqogFV16GXTj/gW02Ux05Q9UdjjWcwaosZPyKwFJdC1n0zubb3bYID
         F99h5KDyD5DeN+iwDvfkKcbuakyvP76c0JjwHtRrDWw3eDpIY3Yw/WnlsaDOcG2QC8Zx
         ecSEf9EU+24gLJWjsNX9tYIeWy+pDZDBq4c3A3s08FbWw5E+ofkxv0Ha/tsAziORwTOi
         4Ptw==
X-Forwarded-Encrypted: i=1; AJvYcCX0nVmScNt7oUGIEy2zlxkHYFhJFQKwGG3uVM46zqsTKpYdPSnTFni8eSLkIFpjpngnsivWZyVh@vger.kernel.org, AJvYcCXaQhMSlvcjxBmSa//HbPKSydbBe6/jnYzCu97HMXptZnI5YQTOQPwKLAhxTz2xrF9zi7qszOxrscu3V3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxE0WrlC0j5xNxgdlEGbFFOGq+9yi3xTAhhz+c7DCTjJX1Tz1
	ORT/jTecEzjeKIhrROWoYVGv0dAesFYvXUJFIDp1GebONrRL2emWQQGN
X-Gm-Gg: ASbGncvCgBazRXenTdroKhrNvm7nrzAboNWSzCV5NlBsmlYmGULrEtYam9genmS5ti2
	sevTvWUGqb8OrKXUTAXThmYCQUF2+eJnzWMSLUlzIkpRRm+jfx3gVbfnJdMKf8cLG5XyYD9gmKG
	vv4i730iJDwrbDKwQN0DeaF/l5oRpkRpLA9zGFUxMZjZ1M0UdkqMfvxMbgTlbrswZAzommMVJNw
	Y6QVHT3TwR81FKb9eGrT533s8i+NazQmh3/lfNxVBR9E4EAAs7lExqcRH/fJfjifE2fJ8kHOpTP
	K096GKbQOU5/srxzN7HAJ8BYlrFtbtkbOeniqwEWmO1CLqGjv/GuB7YPTZP1MmFhz5w4iYDlcQ4
	=
X-Google-Smtp-Source: AGHT+IGdsubvoo2Cv7zpi9HiTbmjbbDaOnWIdnTnJ7OKDIXW1bb2j3+rkMkVq40YIJ+zDstuYfxwbA==
X-Received: by 2002:a05:600c:3e85:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-4533b2428eemr5803465e9.6.1749815739298;
        Fri, 13 Jun 2025 04:55:39 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224795sm50627835e9.7.2025.06.13.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:37 -0700 (PDT)
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
Subject: Re: [PATCH v2 10/12] docs: sphinx: parser_yaml.py: add Netlink
 specs parser
In-Reply-To: <095fba5224a22b86a7604773ddaf9b5193157bc1.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:45:10 +0100
Message-ID: <m2plf7n9vd.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<095fba5224a22b86a7604773ddaf9b5193157bc1.1749723671.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Place the code at parser_yaml.py to handle Netlink specs. All
> other yaml files are ignored.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .pylintrc                           |  2 +-
>  Documentation/sphinx/parser_yaml.py | 39 +++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/.pylintrc b/.pylintrc
> index 30b8ae1659f8..f1d21379254b 100644
> --- a/.pylintrc
> +++ b/.pylintrc
> @@ -1,2 +1,2 @@
>  [MASTER]
> -init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
> +init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi"]'
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index b3cde9cf7aac..eb32e3249274 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -3,6 +3,10 @@ Sphinx extension for processing YAML files
>  """
>  
>  import os
> +import re
> +import sys
> +
> +from pprint import pformat
>  
>  from docutils.parsers.rst import Parser as RSTParser
>  from docutils.statemachine import ViewList
> @@ -10,7 +14,10 @@ from docutils.statemachine import ViewList
>  from sphinx.util import logging
>  from sphinx.parsers import Parser
>  
> -from pprint import pformat
> +srctree = os.path.abspath(os.environ["srctree"])
> +sys.path.insert(0, os.path.join(srctree, "scripts/lib"))
> +
> +from netlink_yml_parser import NetlinkYamlParser      # pylint: disable=C0413
>  
>  logger = logging.getLogger(__name__)
>  
> @@ -19,8 +26,9 @@ class YamlParser(Parser):
>  
>      supported = ('yaml', 'yml')
>  
> -    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> -    def parse(self, inputstring, document):
> +    netlink_parser = NetlinkYamlParser()
> +
> +    def do_parse(self, inputstring, document, msg):
>          """Parse YAML and generate a document tree."""
>  
>          self.setup_parse(inputstring, document)
> @@ -28,14 +36,6 @@ class YamlParser(Parser):
>          result = ViewList()
>  
>          try:
> -            # FIXME: Test logic to generate some ReST content
> -            basename = os.path.basename(document.current_source)
> -            title = os.path.splitext(basename)[0].replace('_', ' ').title()
> -
> -            msg = f"{title}\n"
> -            msg += "=" * len(title) + "\n\n"
> -            msg += "Something\n"
> -
>              # Parse message with RSTParser
>              for i, line in enumerate(msg.split('\n')):
>                  result.append(line, document.current_source, i)
> @@ -48,6 +48,23 @@ class YamlParser(Parser):
>  
>          self.finish_parse()
>  
> +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> +    def parse(self, inputstring, document):
> +        """Check if a YAML is meant to be parsed."""
> +
> +        fname = document.current_source
> +
> +        # Handle netlink yaml specs
> +        if re.search("/netlink/specs/", fname):

The re.search is overkill since it is not a regexp. You can instead say:

    if '/netlink/specs/' in fname:

> +            if fname.endswith("index.yaml"):
> +                msg = self.netlink_parser.generate_main_index_rst(fname, None)
> +            else:

I'm guessing we can drop these lines if the static index.rst approach works.

> +                msg = self.netlink_parser.parse_yaml_file(fname)
> +
> +            self.do_parse(inputstring, document, msg)
> +
> +        # All other yaml files are ignored
> +
>  def setup(app):
>      """Setup function for the Sphinx extension."""

