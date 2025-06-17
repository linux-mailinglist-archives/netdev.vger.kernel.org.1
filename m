Return-Path: <netdev+bounces-198585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF8ADCC5C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE24189AC4C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20FE2EBDFE;
	Tue, 17 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRKUwiLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7762E06D9;
	Tue, 17 Jun 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165213; cv=none; b=V0EoSfUTwEqyTtXtlFdt1NsKv/jKGVWMfCVH9CPYvciyxh+Sm6k//nMFzHTFD9VS9LRjhY2njabzakNO0DiEi7YAqISgHRLAm2omkFAFDZ8WF0pErPbqiX0WjYFq/HJ1dBybspai1PYQ6E6yMKwsWRPLryKzZ3c4aWtvPH2T+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165213; c=relaxed/simple;
	bh=yii0E8vyyXQtfMC+iLqU+waiynyqkPd0yd8VS0g9QR0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Q5eGWx9+kpXQ9a85RdCI0eHHSYJwnCePybFThXz2Q/07WWQLUYAd/3es6/v1CaRzBhc9lw8P2PkEzAKZ7ldz/9wm0ehYz9UxjpO2GTnoW9QKbUb6t6f5rqsNvDi5MZ5H8DOvOXUBiHlOFNvEkrtoNOvObNdYhP2w/Hzax6QRvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRKUwiLH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4533bf4d817so18522955e9.2;
        Tue, 17 Jun 2025 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165205; x=1750770005; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYRRkcWw6OrBwgBLP0U5aOPrCxMMyhIKo7TNxFrB7qY=;
        b=DRKUwiLHQDcLW6tFXJDh0GxOj7FsxvvGzWdTq99QfDff8+PuIImop6iOM1zn03TBYJ
         RCEI05gUF9WDDw9wVAlxClfqo73k7L2TcHwwiXJGqxue0449EtpBUh6VurX34z3lT64S
         eZaQQhmeqRXvebEg7jFnw0DJy3lP/AY8C1SpoaqXR/Z91FlYILmw5gnmwjy68EVxBSSY
         n7NGyIftVDk/O61uJ6TbqyzJRC9zN0F241hFj/bKHo/Oxr7xSrSUMoK3XNPz0DAzL+9O
         5Z0WOott6ai7Sol8HF7xkfwLOebMG5wOQpwk0zSN26zLcuGIIIaZiTaueAkNX/yIIynQ
         aXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165205; x=1750770005;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYRRkcWw6OrBwgBLP0U5aOPrCxMMyhIKo7TNxFrB7qY=;
        b=u3JmaSY/lYWUuUy8psNu0Qy8cdkw8Ds/JwGW1kxCaM4S/pyZwRuiEhX+k1S0LoVqoJ
         ZPxcqVq3fI3Bs2QkXxjE/v/7W0Vki9H88hsUnEKODT8bQKYy15MOFK3qjmzauIvftkDm
         Q34C6DcvONhPr1MFwl+WYB65393ANubBDjw2oSDk6+y0htI7yDipQhoThoRmFJFK2NnA
         abuWHeI460+EEA8p5mN/ALqnoUlQMDv4Lpinria/EE8t8nLklkZgRlw0gHX7aTiImH+U
         5xbivkBkm2HVA8CqSRgFIkeaivyr0PhT54IpkCWk0pmo0XYSimGr1/vTTQecyqDMVbgu
         wKBw==
X-Forwarded-Encrypted: i=1; AJvYcCUqP/s7iU8Y50yYHc4LOku124Uds7D9K+OanHCcvXSBvEnttkrXVzo23cPxM9F8Pe0MDMGJuKJoUiqaU8Q=@vger.kernel.org, AJvYcCXkXGgYtIsp3HCYL+ioAEukckxGuQeg5khItR0wud1s+++Zt+f3c108on0+CHB13R5aAQKddmN5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mpsS1R8/VopNTEbzfOUCWtseBcjA8KSzOxlje8IH8vJR5tyw
	mVrkL/UvYLVhAkKMPbGHTnF45wDJYooOjmjxXL8FXjj2bucI3r4GRT5E
X-Gm-Gg: ASbGncuNC9D2s4An3e4+itOkBd4eA4Wn5RnpEcAt+LdFe2Rx0AxoIeudPkMP4VCDb1j
	xP6gw0izuqGmaknsoymSXqDGQ9Ef+wkiPNmTEj3bvjmATG18tTLxbq85xAh9wjeGumH+dk1p80u
	UjbQsi0YDyUZDiwOKte3lDoaqO8gFnAXmtRbZQffOiD6qWAYk9P48mpVsY+O6tQ9jG/fvX8QkXC
	omh4nOc8iNGBN775o1td+z0dFpPXpukQtKcWATVGy+Zg+S2uVpLoyIB4WUyogOy4ZHTnK8Dptjz
	Pd1L5DABbOsCDHlS0pbV5NCvURqHom/+RT6s7KxTAfn1kCuiV/+Z9c9TpJ0YHqXk6kdEsNlDKuh
	SCVNZ67TvKA==
X-Google-Smtp-Source: AGHT+IHDtDI8eYFMtqapkVPwKVthJgYPyGhAxtltZnr23Q9BdukKqPT1coHXsUHdL3QUsjwpwPcXZg==
X-Received: by 2002:a05:6000:4284:b0:3a4:d53d:be23 with SMTP id ffacd0b85a97d-3a572e79ba7mr10080818f8f.30.1750165205187;
        Tue, 17 Jun 2025 06:00:05 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c4e8sm173342205e9.3.2025.06.17.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:04 -0700 (PDT)
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
Subject: Re: [PATCH v5 06/15] tools: ynl_gen_rst.py: Split library from
 command line tool
In-Reply-To: <26f6087563a1b7f6b26b5f38856ea5f06f528fee.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 12:08:42 +0100
Message-ID: <m2frfyk4lh.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<26f6087563a1b7f6b26b5f38856ea5f06f528fee.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we'll be using the Netlink specs parser inside a Sphinx
> extension, move the library part from the command line parser.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/net/ynl/pyynl/netlink_yml_parser.py | 391 ++++++++++++++++++++++
>  tools/net/ynl/pyynl/ynl_gen_rst.py        | 374 +--------------------
>  2 files changed, 401 insertions(+), 364 deletions(-)
>  create mode 100755 tools/net/ynl/pyynl/netlink_yml_parser.py

Sorry, the directory should be tools/net/ynl/pyynl/lib

Can you also name this something like doc_generator.py since the parsing
is incidental, the primary function is ReST doc generation.

[...]

> +# Main functions
> +# ==============
> +
> +
> +def parse_yaml_file(filename: str) -> str:
> +    """Transform the YAML specified by filename into an RST-formatted string"""
> +    with open(filename, "r", encoding="utf-8") as spec_file:
> +        yaml_data = yaml.safe_load(spec_file)
> +        content = parse_yaml(yaml_data)
> +
> +    return content
> +
> +
> +def generate_main_index_rst(output: str, index_dir: str) -> str:

Can you leave this function in ynl_gen_rst.py because it is not required
in the doc generator library and anyway gets removed later in the
series.

> +    """Generate the `networking_spec/index` content and write to the file"""
> +    lines = []
> +
> +    lines.append(rst_header())
> +    lines.append(rst_label("specs"))
> +    lines.append(rst_title("Netlink Family Specifications"))
> +    lines.append(rst_toctree(1))
> +
> +    index_fname = os.path.basename(output)
> +    base, ext = os.path.splitext(index_fname)
> +
> +    if not index_dir:
> +        index_dir = os.path.dirname(output)
> +
> +    logging.debug(f"Looking for {ext} files in %s", index_dir)
> +    for filename in sorted(os.listdir(index_dir)):
> +        if not filename.endswith(ext) or filename == index_fname:
> +            continue
> +        base, ext = os.path.splitext(filename)
> +        lines.append(f"   {base}\n")
> +
> +    return "".join(lines), output
> diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> index b1e5acafb998..38dafe3d9179 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> @@ -18,345 +18,17 @@
>          3) Main function and small helpers
>  """
>  
> -from typing import Any, Dict, List
>  import os.path
>  import sys
>  import argparse
>  import logging
> -import yaml
>  
> +LIB_DIR = "../../../../scripts/lib"

Leftover from previous version?

> +SRC_DIR = os.path.dirname(os.path.realpath(__file__))
>  
> -SPACE_PER_LEVEL = 4
> +sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))

This is what we have in the other scripts in tools/net/ynl/pyynl:

sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())

>  
> -
> -# RST Formatters
> -# ==============
> -def headroom(level: int) -> str:
> -    """Return space to format"""
> -    return " " * (level * SPACE_PER_LEVEL)
> -
> -
> -def bold(text: str) -> str:
> -    """Format bold text"""
> -    return f"**{text}**"
> -
> -
> -def inline(text: str) -> str:
> -    """Format inline text"""
> -    return f"``{text}``"
> -
> -
> -def sanitize(text: str) -> str:
> -    """Remove newlines and multiple spaces"""
> -    # This is useful for some fields that are spread across multiple lines
> -    return str(text).replace("\n", " ").strip()
> -
> -
> -def rst_fields(key: str, value: str, level: int = 0) -> str:
> -    """Return a RST formatted field"""
> -    return headroom(level) + f":{key}: {value}"
> -
> -
> -def rst_definition(key: str, value: Any, level: int = 0) -> str:
> -    """Format a single rst definition"""
> -    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
> -
> -
> -def rst_paragraph(paragraph: str, level: int = 0) -> str:
> -    """Return a formatted paragraph"""
> -    return headroom(level) + paragraph
> -
> -
> -def rst_bullet(item: str, level: int = 0) -> str:
> -    """Return a formatted a bullet"""
> -    return headroom(level) + f"- {item}"
> -
> -
> -def rst_subsection(title: str) -> str:
> -    """Add a sub-section to the document"""
> -    return f"{title}\n" + "-" * len(title)
> -
> -
> -def rst_subsubsection(title: str) -> str:
> -    """Add a sub-sub-section to the document"""
> -    return f"{title}\n" + "~" * len(title)
> -
> -
> -def rst_section(namespace: str, prefix: str, title: str) -> str:
> -    """Add a section to the document"""
> -    return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
> -
> -
> -def rst_subtitle(title: str) -> str:
> -    """Add a subtitle to the document"""
> -    return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
> -
> -
> -def rst_title(title: str) -> str:
> -    """Add a title to the document"""
> -    return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
> -
> -
> -def rst_list_inline(list_: List[str], level: int = 0) -> str:
> -    """Format a list using inlines"""
> -    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
> -
> -
> -def rst_ref(namespace: str, prefix: str, name: str) -> str:
> -    """Add a hyperlink to the document"""
> -    mappings = {'enum': 'definition',
> -                'fixed-header': 'definition',
> -                'nested-attributes': 'attribute-set',
> -                'struct': 'definition'}
> -    if prefix in mappings:
> -        prefix = mappings[prefix]
> -    return f":ref:`{namespace}-{prefix}-{name}`"
> -
> -
> -def rst_header() -> str:
> -    """The headers for all the auto generated RST files"""
> -    lines = []
> -
> -    lines.append(rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
> -    lines.append(rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
> -
> -    return "\n".join(lines)
> -
> -
> -def rst_toctree(maxdepth: int = 2) -> str:
> -    """Generate a toctree RST primitive"""
> -    lines = []
> -
> -    lines.append(".. toctree::")
> -    lines.append(f"   :maxdepth: {maxdepth}\n\n")
> -
> -    return "\n".join(lines)
> -
> -
> -def rst_label(title: str) -> str:
> -    """Return a formatted label"""
> -    return f".. _{title}:\n\n"
> -
> -
> -# Parsers
> -# =======
> -
> -
> -def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
> -    """Parse 'multicast' group list and return a formatted string"""
> -    lines = []
> -    for group in mcast_group:
> -        lines.append(rst_bullet(group["name"]))
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
> -    """Parse 'do' section and return a formatted string"""
> -    lines = []
> -    for key in do_dict.keys():
> -        lines.append(rst_paragraph(bold(key), level + 1))
> -        if key in ['request', 'reply']:
> -            lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
> -        else:
> -            lines.append(headroom(level + 2) + do_dict[key] + "\n")
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
> -    """Parse 'attributes' section"""
> -    if "attributes" not in attrs:
> -        return ""
> -    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
> -    """Parse operations block"""
> -    preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
> -    linkable = ["fixed-header", "attribute-set"]
> -    lines = []
> -
> -    for operation in operations:
> -        lines.append(rst_section(namespace, 'operation', operation["name"]))
> -        lines.append(rst_paragraph(operation["doc"]) + "\n")
> -
> -        for key in operation.keys():
> -            if key in preprocessed:
> -                # Skip the special fields
> -                continue
> -            value = operation[key]
> -            if key in linkable:
> -                value = rst_ref(namespace, key, value)
> -            lines.append(rst_fields(key, value, 0))
> -        if 'flags' in operation:
> -            lines.append(rst_fields('flags', rst_list_inline(operation['flags'])))
> -
> -        if "do" in operation:
> -            lines.append(rst_paragraph(":do:", 0))
> -            lines.append(parse_do(operation["do"], 0))
> -        if "dump" in operation:
> -            lines.append(rst_paragraph(":dump:", 0))
> -            lines.append(parse_do(operation["dump"], 0))
> -
> -        # New line after fields
> -        lines.append("\n")
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
> -    """Parse a list of entries"""
> -    ignored = ["pad"]
> -    lines = []
> -    for entry in entries:
> -        if isinstance(entry, dict):
> -            # entries could be a list or a dictionary
> -            field_name = entry.get("name", "")
> -            if field_name in ignored:
> -                continue
> -            type_ = entry.get("type")
> -            if type_:
> -                field_name += f" ({inline(type_)})"
> -            lines.append(
> -                rst_fields(field_name, sanitize(entry.get("doc", "")), level)
> -            )
> -        elif isinstance(entry, list):
> -            lines.append(rst_list_inline(entry, level))
> -        else:
> -            lines.append(rst_bullet(inline(sanitize(entry)), level))
> -
> -    lines.append("\n")
> -    return "\n".join(lines)
> -
> -
> -def parse_definitions(defs: Dict[str, Any], namespace: str) -> str:
> -    """Parse definitions section"""
> -    preprocessed = ["name", "entries", "members"]
> -    ignored = ["render-max"]  # This is not printed
> -    lines = []
> -
> -    for definition in defs:
> -        lines.append(rst_section(namespace, 'definition', definition["name"]))
> -        for k in definition.keys():
> -            if k in preprocessed + ignored:
> -                continue
> -            lines.append(rst_fields(k, sanitize(definition[k]), 0))
> -
> -        # Field list needs to finish with a new line
> -        lines.append("\n")
> -        if "entries" in definition:
> -            lines.append(rst_paragraph(":entries:", 0))
> -            lines.append(parse_entries(definition["entries"], 1))
> -        if "members" in definition:
> -            lines.append(rst_paragraph(":members:", 0))
> -            lines.append(parse_entries(definition["members"], 1))
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_attr_sets(entries: List[Dict[str, Any]], namespace: str) -> str:
> -    """Parse attribute from attribute-set"""
> -    preprocessed = ["name", "type"]
> -    linkable = ["enum", "nested-attributes", "struct", "sub-message"]
> -    ignored = ["checks"]
> -    lines = []
> -
> -    for entry in entries:
> -        lines.append(rst_section(namespace, 'attribute-set', entry["name"]))
> -        for attr in entry["attributes"]:
> -            type_ = attr.get("type")
> -            attr_line = attr["name"]
> -            if type_:
> -                # Add the attribute type in the same line
> -                attr_line += f" ({inline(type_)})"
> -
> -            lines.append(rst_subsubsection(attr_line))
> -
> -            for k in attr.keys():
> -                if k in preprocessed + ignored:
> -                    continue
> -                if k in linkable:
> -                    value = rst_ref(namespace, k, attr[k])
> -                else:
> -                    value = sanitize(attr[k])
> -                lines.append(rst_fields(k, value, 0))
> -            lines.append("\n")
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_sub_messages(entries: List[Dict[str, Any]], namespace: str) -> str:
> -    """Parse sub-message definitions"""
> -    lines = []
> -
> -    for entry in entries:
> -        lines.append(rst_section(namespace, 'sub-message', entry["name"]))
> -        for fmt in entry["formats"]:
> -            value = fmt["value"]
> -
> -            lines.append(rst_bullet(bold(value)))
> -            for attr in ['fixed-header', 'attribute-set']:
> -                if attr in fmt:
> -                    lines.append(rst_fields(attr,
> -                                            rst_ref(namespace, attr, fmt[attr]),
> -                                            1))
> -            lines.append("\n")
> -
> -    return "\n".join(lines)
> -
> -
> -def parse_yaml(obj: Dict[str, Any]) -> str:
> -    """Format the whole YAML into a RST string"""
> -    lines = []
> -
> -    # Main header
> -
> -    family = obj['name']
> -
> -    lines.append(rst_header())
> -    lines.append(rst_label("netlink-" + family))
> -
> -    title = f"Family ``{family}`` netlink specification"
> -    lines.append(rst_title(title))
> -    lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
> -
> -    if "doc" in obj:
> -        lines.append(rst_subtitle("Summary"))
> -        lines.append(rst_paragraph(obj["doc"], 0))
> -
> -    # Operations
> -    if "operations" in obj:
> -        lines.append(rst_subtitle("Operations"))
> -        lines.append(parse_operations(obj["operations"]["list"], family))
> -
> -    # Multicast groups
> -    if "mcast-groups" in obj:
> -        lines.append(rst_subtitle("Multicast groups"))
> -        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
> -
> -    # Definitions
> -    if "definitions" in obj:
> -        lines.append(rst_subtitle("Definitions"))
> -        lines.append(parse_definitions(obj["definitions"], family))
> -
> -    # Attributes set
> -    if "attribute-sets" in obj:
> -        lines.append(rst_subtitle("Attribute sets"))
> -        lines.append(parse_attr_sets(obj["attribute-sets"], family))
> -
> -    # Sub-messages
> -    if "sub-messages" in obj:
> -        lines.append(rst_subtitle("Sub-messages"))
> -        lines.append(parse_sub_messages(obj["sub-messages"], family))
> -
> -    return "\n".join(lines)
> -
> -
> -# Main functions
> -# ==============
> +from netlink_yml_parser import parse_yaml_file, generate_main_index_rst
>  
>  
>  def parse_arguments() -> argparse.Namespace:
> @@ -393,50 +65,24 @@ def parse_arguments() -> argparse.Namespace:
>      return args
>  
>  
> -def parse_yaml_file(filename: str) -> str:
> -    """Transform the YAML specified by filename into an RST-formatted string"""
> -    with open(filename, "r", encoding="utf-8") as spec_file:
> -        yaml_data = yaml.safe_load(spec_file)
> -        content = parse_yaml(yaml_data)
> -
> -    return content
> -
> -
>  def write_to_rstfile(content: str, filename: str) -> None:
>      """Write the generated content into an RST file"""
>      logging.debug("Saving RST file to %s", filename)
>  
> -    dir = os.path.dirname(filename)
> -    os.makedirs(dir, exist_ok=True)
> +    directory = os.path.dirname(filename)
> +    os.makedirs(directory, exist_ok=True)
>  
>      with open(filename, "w", encoding="utf-8") as rst_file:
>          rst_file.write(content)
>  
>  
> -def generate_main_index_rst(output: str, index_dir: str) -> None:
> +def write_index_rst(output: str, index_dir: str) -> None:

This change can also be dropped, to simplify the series.

>      """Generate the `networking_spec/index` content and write to the file"""
> -    lines = []
>  
> -    lines.append(rst_header())
> -    lines.append(rst_label("specs"))
> -    lines.append(rst_title("Netlink Family Specifications"))
> -    lines.append(rst_toctree(1))
> -
> -    index_fname = os.path.basename(output)
> -    base, ext = os.path.splitext(index_fname)
> -
> -    if not index_dir:
> -        index_dir = os.path.dirname(output)
> -
> -    logging.debug(f"Looking for {ext} files in %s", index_dir)
> -    for filename in sorted(os.listdir(index_dir)):
> -        if not filename.endswith(ext) or filename == index_fname:
> -            continue
> -        base, ext = os.path.splitext(filename)
> -        lines.append(f"   {base}\n")
> +    msg = generate_main_index_rst(output, index_dir)
>  
>      logging.debug("Writing an index file at %s", output)
> -    write_to_rstfile("".join(lines), output)
> +    write_to_rstfile(msg, output)
>  
>  
>  def main() -> None:
> @@ -457,7 +103,7 @@ def main() -> None:
>  
>      if args.index:
>          # Generate the index RST file
> -        generate_main_index_rst(args.output, args.input_dir)
> +        write_index_rst(args.output, args.input_dir)

This change can also be dropped, to simplify the series.

>  
>  
>  if __name__ == "__main__":

