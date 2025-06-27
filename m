Return-Path: <netdev+bounces-201889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147BBAEB5F4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C64B7B5326
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B12BEC28;
	Fri, 27 Jun 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adl5nFO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432329DB7F;
	Fri, 27 Jun 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022297; cv=none; b=R/JS9IZntiOpZUT6tYa6+qX6nhf3b0X3G7v64GQ0EK/JkL+SgH1FNiGlo1KUB+HKRAjPIrGZ/Vf35mnmfo4P5eMldDIdWLMtwICMavD+PqV9yW24nheBsrpkEkJcXVdPa2wkSDiHRIGU7/abV4/RfCjkjXBhLoGScq6EWn8PPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022297; c=relaxed/simple;
	bh=UXA/DCfJJfynwzqK4+DzTCalL4EQVESHifFAflGK+pI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WXkBTopR2j7qol2ee9k9p/P29BG1ISZeyND0QtSbGeVCxaTiHAjLAE3qqxfSr2/f8mypFNo08W2x/ilQY77+MlJQXPpD4tTIjyo5auyIAWG9H5rhkrGI/3tunX9D0r7iQiUVvD166FMtsRGucPOj0rOEyuxrnaVNnYhfRiTLUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adl5nFO0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45377776935so21744805e9.3;
        Fri, 27 Jun 2025 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022294; x=1751627094; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrT0rtgl/4Y4s9eIDFIiuoNzQHixBqPthpAEA+N878k=;
        b=adl5nFO0HlC/5wl87HV7yLr6iDR6xPfbEfyRZYb5BAxxws+Rk+w+vy/MBftNJ3Qpcg
         2xLr36FgaAtnbIs8cq30KjwsenHsRYOt7Escopyyv1nKp2Xdv823J74kKnszEJ0VG3et
         fTjJciXqQLlOwAdVVBFKSMBQ5pDwIkVsUwc2bZXjR7zA/SR6J7nSVNQtZiMejqQ3pCdn
         mZlp8QO1e+zQ719YLVScEs3IOSZRmp1JcY3mS0oryoifM2AETHTpe9MKuJbKo2m37F2/
         c5h9DxZ42ltFpJ/nGFe95Eit+DKgdg3vvKeSwRp2IWMaqTjXc6W982CT25Nxmy3f3iDA
         PL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022294; x=1751627094;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrT0rtgl/4Y4s9eIDFIiuoNzQHixBqPthpAEA+N878k=;
        b=mbVkx1P6jfS7ib+VuyLsHItATPNRRt4v1ci2LO9zZs/KAIbe95pV+Dq0JlzygxR3Nx
         jvP4/VpS7NNceA4dOHhMkk/xDZV5/fYPOg1Y9chE7SeMZc7L1cbmF2WQD4fOdQUq4E6K
         HOzALk7CqakaYVkHB2HPASHvq6KcSABdIbbViy3UU4wND4qWSTSl2QrcLFLB8iqjM654
         y5/Kc4NcdnfozfN5DOHXHguHx/h08B1KW3iUI1z88ZAFCvCwnDQinN2gwC05gRqvwgVG
         qWAg0wfcuuUnBtxeNR84hop6LutsGOq6OPc9oCTQHwXDf0d5MD4eaLqJ3Vdlmkr//O+T
         8b5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuTWBifClmhljj/W6FV7o1AZXW/GhXvr7JZO9Bw7zznes9aeDdcHoS4jAwkgpQWrrTYeJhFWiYOoaiMX4=@vger.kernel.org, AJvYcCX/QKoSiec+jIe0jlk5KFk7bjEB8Z45fA7lVS4jP6pGZYOK/SDiaCNAP2YTbkh6QsQcD9VhEbnC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps3iUgwWrgqXbY/xaQ6G4qcuREj6nuA0UOn8uTX0fEZOYaifu
	4EhEX4gnDiLlh6vBm8zpubFJyi9nHnxWOBctxnlGkFsef9uEHwznWD3b
X-Gm-Gg: ASbGncvhObV9qsieUoa/kesnRODgBUf8xYnhdg4vu67QmmHn4QoEd55+ixLmlZHvpaD
	meVMLmUXtlJp6deJqVjlT4BTv7SbK3e57WJckX+tZ7+JDyuyzQ3wCVYdg24eqkIxBMtNyGnUl+W
	C5O/Kb8HP4cMaiiGrQ1l10L3C0CNBzeCub4OHat/nw1UgHZgU8ur4zJLG4tJ94Mf+PmWYBhTUNB
	Y4T+cYgpF/fdPwgM7KIJGTR6cCBS+6sG081jNpWwhy/C2Jr0066UgW+PWiV3zDgZHnt5u4fRz/M
	5fXe4qMld62zbfPcTXwZqR/0UrZh2kd8e4V2R2MxDxcgEF/zw173F6hYGARvyh9lUoW9c+SJug=
	=
X-Google-Smtp-Source: AGHT+IFux+ewCwtnJcEJvrjwqlskPEmkgrl1E+OU03sLHBdk11oKlm1P+t6SRfzMLWPuNppfl0p/OQ==
X-Received: by 2002:a05:600c:c163:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-4538ee7db55mr33679085e9.16.1751022293718;
        Fri, 27 Jun 2025 04:04:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d05sm48152745e9.2.2025.06.27.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:04:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Ruben Wauters" <rubenru09@aol.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  joel@joelfernandes.org,
  linux-kernel-mentees@lists.linux.dev,  linux-kernel@vger.kernel.org,
  lkmm@lists.linux.dev,  netdev@vger.kernel.org,  peterz@infradead.org,
  stern@rowland.harvard.edu
Subject: Re: [PATCH v8 05/13] docs: sphinx: add a parser for yaml files for
 Netlink specs
In-Reply-To: <8373667e90bf5b184dfd28393fe6a955cdb4bbb7.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 11:25:54 +0100
Message-ID: <m21pr5a3bh.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<8373667e90bf5b184dfd28393fe6a955cdb4bbb7.1750925410.git.mchehab+huawei@kernel.org>
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

This should be: from doc_generator import YnlDocGenerator

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
>  Documentation/sphinx/parser_yaml.py | 104 ++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100755 Documentation/sphinx/parser_yaml.py
>
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> new file mode 100755
> index 000000000000..585a7ec81ba0
> --- /dev/null
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
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

So that it doesn't need to be changed in a later patch, this should be:

... "tools/net/ynl/pyynl/lib"

> +
> +from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413

So that it doesn't need to be changed in a later patch, this should be:

from doc_generator ...

> +logger = logging.getLogger(__name__)
> +
> +class YamlParser(Parser):
> +    """
> +    Kernel parser for YAML files.
> +
> +    This is a simple sphinx.Parser to handle yaml files inside the
> +    Kernel tree that will be part of the built documentation.
> +
> +    The actual parser function is not contained here: the code was
> +    written in a way that parsing yaml for different subsystems
> +    can be done from a single dispatcher.
> +
> +    All it takes to have parse YAML patches is to have an import line:
> +
> +            from some_parser_code import NewYamlGenerator
> +
> +    To this module. Then add an instance of the parser with:
> +
> +            new_parser = NewYamlGenerator()
> +
> +    and add a logic inside parse() to handle it based on the path,
> +    like this:
> +
> +            if "/foo" in fname:
> +                msg = self.new_parser.parse_yaml_file(fname)
> +    """
> +
> +    supported = ('yaml', )
> +
> +    netlink_parser = YnlDocGenerator()
> +
> +    def rst_parse(self, inputstring, document, msg):
> +        """
> +        Receives a ReST content that was previously converted by the
> +        YAML parser, adding it to the document tree.
> +        """
> +
> +        self.setup_parse(inputstring, document)
> +
> +        result = ViewList()
> +
> +        try:
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
> +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> +    def parse(self, inputstring, document):
> +        """Check if a YAML is meant to be parsed."""
> +
> +        fname = document.current_source
> +
> +        # Handle netlink yaml specs
> +        if "/netlink/specs/" in fname:
> +            msg = self.netlink_parser.parse_yaml_file(fname)
> +            self.rst_parse(inputstring, document, msg)
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

