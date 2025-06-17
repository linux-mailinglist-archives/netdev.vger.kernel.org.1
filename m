Return-Path: <netdev+bounces-198587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633DBADCC6C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9413B74E9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060AD2ED847;
	Tue, 17 Jun 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9N7Ra9y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369F2EBDC2;
	Tue, 17 Jun 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165215; cv=none; b=MeicVRfTNxr+cGQ4fSNFJAaHvlXIGciZ5zb2UBweaYgGNvdbIE4DFqDzlyZ29UEBCoL0210d50PcnAxTWB2U3YH3H+1gyOEIVM3vXQfagddkIpb557BEXgt+deQYkUdJ7nBf3i0w4lLYXT1Z6qF79DzZf3iPK1oja1g/y3mRudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165215; c=relaxed/simple;
	bh=vKPakfogKKix3izDDBo9OyyTz68HN3ZhsLtr7WF+d3k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=O6nggdPGdxq9BEALyl7intIQcsPON7Lz3wPb2/h8Y4kMmU/zDtzA0ZuWVXvIarT6pmLrlaf7SeUZyCRt4hsSd9JWEohZJwZLtputDNUHdOwW4gvWC/YLUhBTxZUA35yHuCWeNv/U+9lfB6yFKM8y1wS3Cm4yGD/3yk1UK6VCzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9N7Ra9y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so1690978f8f.0;
        Tue, 17 Jun 2025 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165210; x=1750770010; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYoy6x7UGY+cu6w5H/g64EV7yFmP0q4eOzaGrrkLz/0=;
        b=T9N7Ra9yBuwOM7xd7V9rKiT1YsFBB8wTwgsRER2CgRCTETqyQcBlzLuKcvFuDRWjw/
         XRqKuNiGrDBe2E7eOG0UDQOqjVAswlNgMFtr8QrC6rhURYuZLmWceNOpOQvbgRK3BkDi
         KjegKC3QAnOdRHuXClmBDn2ZzZCuh/cgbDq6I4JHU1GaUAX8mhtQG8BHDBZKCpVmVOV3
         6lbOHlxvvXRZ/gmtLmvLnUJjhZNZzRKFE0V1zdPonLTLrtIEVflgnoTqMa37ZMYZVfr8
         x2qXlIMtlnJykJc+99FUJEmN34i6I763QR/82AfD52obCclBL9lowwoVGFPO6v3JBiYI
         yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165210; x=1750770010;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYoy6x7UGY+cu6w5H/g64EV7yFmP0q4eOzaGrrkLz/0=;
        b=eaCmBGNLp3Fga1vDE8Ra0GlchAthwBNTbcHNk+GYcr9RirjlD3nZOnJLMPCqwZSWPc
         nSGbNaE4s3aolC1OJnlqF+hQ879UfcdaOdPps3Wn7+YNpMw/r9LMlxtxO6il2xfJbBEn
         4OM1OGWDJKHic1rAihwiYXJSO5xrNsTd6Yrf5SOt+WqdmgoY3mk58xmfDk4Msivjk7GZ
         4MfBEDVnO0yMgOj7e6L6RGAAzLDfLgudOTksHuqZT3k268CoXiRiDx8tjB8jR036QQeX
         Om2CMsJYReEQHDq0knvMqm/bWVTqbuzoVeH5XszdODjLC1oOQLBKmrcTJgjpnnkfrjw3
         Z36g==
X-Forwarded-Encrypted: i=1; AJvYcCUlkeYdOTsq36ggP17tf4es3TOoZOWbRrzZsws/MW7Lyxj1llI7fwVe/fDewCZ3PZKEEqtvdRev@vger.kernel.org, AJvYcCVY3px6qH3kVZKd/oVVTZmT7sX5jzcSaw9orqrGeRWtGlzADtgcjnJ9BSvxnBTmyQNpv1D6dCzwK7r9ctM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1LBnr3hvkDA6NSdEZWWG+3Vi9OlNJBqOacO0olyNRjoN+jer
	cZTNyDd0QRDWNE1bKNw52LyVFMfcmYEr7r/kTFRwGzQygYfypAaoXaxEo6r7Od8g
X-Gm-Gg: ASbGnct+dmPrDG0wBj69Y01S7Jie7jbsoIW5e88dhVOpoTA3bXsmECcuH6rGRmwpQxu
	AhvMzFScA0vyNUrpGzm7gKdmib4uIvvALV3+p+KPOHcMf+Rctn/0A8HYMfLzF2vVG2JvKfa4EhP
	IWfTmEx47UzF3AVeoxInxy5CsDNf+wx9VdHQtKwTt3OYHFB0Ibs1KUOwSrL7ROBV6eJxlLob1R/
	RqZJwL/4l3nU1Ui6AR7ssHHpOmzUWTJqXtEckfypWnot6nRO7hVPpga4eg6s4CqZVD2EUmFAEAB
	urdOlacm35qeiDxElMfj84MMihaW7DJo35uDuf0jl1zyHykYO42vBfmQiO2saDS0W/Z1NENRsXc
	=
X-Google-Smtp-Source: AGHT+IFFtE66j0KBeiVBmHT2kdpGgOwXtX4PGlW51AaI/zJ78oGV7HwQmIMFUGUqOcnRWs2CbvgRsw==
X-Received: by 2002:a05:6000:24c8:b0:3a4:f918:9db9 with SMTP id ffacd0b85a97d-3a572e79fa4mr10169058f8f.32.1750165209425;
        Tue, 17 Jun 2025 06:00:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a800d9sm13815810f8f.45.2025.06.17.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:08 -0700 (PDT)
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
Subject: Re: [PATCH v5 10/15] docs: sphinx: add a parser for yaml files for
 Netlink specs
In-Reply-To: <c407d769c9f47083e8f411c13989522e32262562.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 13:35:50 +0100
Message-ID: <m27c1ak0k9.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<c407d769c9f47083e8f411c13989522e32262562.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Add a simple sphinx.Parser to handle yaml files and add the
> the code to handle Netlink specs. All other yaml files are
> ignored.
>
> The code was written in a way that parsing yaml for different
> subsystems and even for different parts of Netlink are easy.
>
> All it takes to have a different parser is to add an
> import line similar to:
>
> 	from netlink_yml_parser import YnlDocGenerator
>
> adding the corresponding parser somewhere at the extension:
>
> 	netlink_parser = YnlDocGenerator()
>
> And then add a logic inside parse() to handle different
> doc outputs, depending on the file location, similar to:
>
>         if "/netlink/specs/" in fname:
>             msg = self.netlink_parser.parse_yaml_file(fname)
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/sphinx/parser_yaml.py | 76 +++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100755 Documentation/sphinx/parser_yaml.py
>
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> new file mode 100755
> index 000000000000..635945e1c5ba
> --- /dev/null
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -0,0 +1,76 @@
> +"""
> +Sphinx extension for processing YAML files
> +"""
> +
> +import os
> +import re
> +import sys
> +
> +from pprint import pformat
> +
> +from docutils.parsers.rst import Parser as RSTParser
> +from docutils.statemachine import ViewList
> +
> +from sphinx.util import logging
> +from sphinx.parsers import Parser
> +
> +srctree = os.path.abspath(os.environ["srctree"])
> +sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
> +
> +from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
> +
> +logger = logging.getLogger(__name__)
> +
> +class YamlParser(Parser):
> +    """Custom parser for YAML files."""

Would be good to say that this is a common YAML parser that calls
different subsystems, e.g. how you described it in the commit message.

> +
> +    # Need at least two elements on this set

I think you can drop this comment. It's not that it must be two
elements, it's that supported needs to be a list and the python syntax
to force parsing as a list would be ('item', )

> +    supported = ('yaml', 'yml')
> +
> +    netlink_parser = YnlDocGenerator()
> +
> +    def do_parse(self, inputstring, document, msg):

Maybe a better name for this is parse_rst?

> +        """Parse YAML and generate a document tree."""

Also update comment.

> +
> +        self.setup_parse(inputstring, document)
> +
> +        result = ViewList()
> +
> +        try:
> +            # Parse message with RSTParser
> +            for i, line in enumerate(msg.split('\n')):
> +                result.append(line, document.current_source, i)

This has the effect of associating line numbers from the generated ReST
with the source .yaml file, right? So errors will be reported against
the wrong place in the file. Is there any way to show the cause of the
error in the intermediate ReST?

As an example if I modify tc.yaml like this:

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4cc1f6a45001..c36d86d2dc72 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -4044,7 +4044,9 @@ operations:
             - chain
     -
       name: getchain
-      doc: Get / dump tc chain information.
+      doc: |
+        Get / dump tc chain information.
+        .. bogus-directive:: 
       attribute-set: attrs
       fixed-header: tcmsg
       do:

This is the resuting error which will be really hard to track down:

/home/donaldh/net-next/Documentation/netlink/specs/tc.yaml:216: ERROR: Unexpected indentation. [docutils]

> +
> +            rst_parser = RSTParser()
> +            rst_parser.parse('\n'.join(result), document)
> +
> +        except Exception as e:
> +            document.reporter.error("YAML parsing error: %s" % pformat(e))
> +
> +        self.finish_parse()
> +
> +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> +    def parse(self, inputstring, document):
> +        """Check if a YAML is meant to be parsed."""
> +
> +        fname = document.current_source
> +
> +        # Handle netlink yaml specs
> +        if "/netlink/specs/" in fname:
> +            msg = self.netlink_parser.parse_yaml_file(fname)
> +            self.do_parse(inputstring, document, msg)
> +
> +        # All other yaml files are ignored
> +
> +def setup(app):
> +    """Setup function for the Sphinx extension."""
> +
> +    # Add YAML parser
> +    app.add_source_parser(YamlParser)
> +    app.add_source_suffix('.yaml', 'yaml')
> +
> +    return {
> +        'version': '1.0',
> +        'parallel_read_safe': True,
> +        'parallel_write_safe': True,
> +    }

