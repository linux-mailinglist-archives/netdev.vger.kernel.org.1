Return-Path: <netdev+bounces-197763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D33AD9D4C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160CD3ABDFA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3E2D8DB1;
	Sat, 14 Jun 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNs4STsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC902C15AC;
	Sat, 14 Jun 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910197; cv=none; b=FPEO1RT/qrgE9ZalQsS+8vT9YbvdAX8OJR1K5sP46MaV00JbaB9aCMkcxgCPdgBPLKk07zfA8cGlkw/cH5dilu+cZaqFi8kDvXzM3qvkOfU/MJy1r7E+F2zFfpCvdYRubNOC1tmGN2mU+TOqIG9mIiPrmNkZXm76AuAp8IcOwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910197; c=relaxed/simple;
	bh=/6EGyCaLMj+aYPgs/K1kLOakg5zEmh97GjsTmhWeRgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMLtRtAfq1KpV3Otfw6y51PcD/QAKIKVOfjaIq9hPpJyfkewefU0UQCfaWkXysRmsP0i9/imxvfNbluWCuJ8+c8cb2eAbdCAebs0HDfFV/IrfYeuYm0EHz84Zt6idR5p2Bmj3uK2NBAauu1uoi7dNM2d8gPt2JfiUExGPMu79bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNs4STsP; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-605fda00c30so1792491eaf.1;
        Sat, 14 Jun 2025 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749910194; x=1750514994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCUXcHBzOMKGXfBRpwprWwIRZd/x62mrCYSp/asydM0=;
        b=dNs4STsPAfgDyPiEDTh3uSuosyVPENYvTTtPpoTdGPg92Xpn7EKWpJKUlomrYlAOw5
         QOUOeuatEVJwd++2pwr1eMx2oDB7ThHHUY4T9nt+7T4kHOxHKqW9igsF6IYYu4SsptmQ
         Pa4R0IklA7VypvYjqUEz7JJXg2rWYTJimiQrzDx/SN7txIWDbKnYXnlKhXLBrAojp7KC
         qVP1MrN/cfQK/8GN0lB/AuAOAPUXmdu9Q0GUn/DeanKEJCaOu/gwfP0xkcncjMzifzvO
         4lgomcs2HrE0fecq4aCI93pDbe11/z6bYkpi2MGtx0lXmm14QeC2thS+rawbrqPRTkZ5
         soPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749910194; x=1750514994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCUXcHBzOMKGXfBRpwprWwIRZd/x62mrCYSp/asydM0=;
        b=j49Z/XMWlOH2wbA8r2stB4/QIaHB0TbyPG2PW9P0/I/XNYV5/S2trAGtmPXJzAD9OL
         6bQHbd6DlYSMdWOzYovS0GPndlEdx2oYpyjFQmCH+8Mvu7VTGg6mXFPDGjU7nm7c14qO
         ZvSwllwNuIlzeInFpt6fumDbq8b//0z7UA2IEwRIVA5Q6vkqxRkPDYGfP+RGX3Pji5Sz
         yDl2v/SBgrqPxaux/B0VoOqS/+T+CGYmOQi3Q6nGaO8cFeAPbcS74BtYEyvU9CMfRD2i
         cNhfSjWiSsE0va02zwYtkPt/+KVG62P44+CzwWaZlliErS4yv3UhMqF6qij091MzgrNU
         RzqA==
X-Forwarded-Encrypted: i=1; AJvYcCURev/zSb1nGTDRAKMMYLlJ0mT2GqwedNEs0cRsJOnJNUKmKfwgbbW6t1SiGUSQ1rfYjjdi96R5@vger.kernel.org, AJvYcCX2b9hiKw+yWLYTGSPV65gX5FkRZ2KeueHSiWF90w6aR1KU7Y1ex6Yk14ekk8wBa3O0o3N6YxnT03XA1OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkoSE61ZmTuAnd9QyLs07UKsgVQz+TB4+3Tj2FnQSWkHXRujW
	GrwbGbEX+xwNtoqh3n5pdfnNR38XMJQ4todsqZH8JJe+UaTd+2rFtUgS8ocEMQv1oI0DK6EShor
	coYs6b0fmVsnV53g6DdZ4kC32+ncd82k=
X-Gm-Gg: ASbGncvZNden03qL/oX1k6/yUV154BYZH7z88ygc6SGti89/cq7fiNRghnhR6BijTy6
	xNuTu4LRVBCc2LeRxuBQaNYygGYWhjHeKTJeIGe7og8lqle7XgixNzujaf6hSl5zcTz7OX91QKV
	QgituL9vYZDKSTTgQVl+ADnfKVomaMaaS32zgrqO+6tGbfJ3PXTXRgVQ4SRUgLD4beOEYsr7UjN
	g==
X-Google-Smtp-Source: AGHT+IGM9/z1MmutaZK69keedUHrYKIn7PXeRTsW6LvZz6NFbw7ssXw+JPFaIn3BBz+TRvZczSS+EYJIejP2CQInAPU=
X-Received: by 2002:a05:6870:241a:b0:2bc:9197:3508 with SMTP id
 586e51a60fabf-2eaf0b1355amr2326336fac.34.1749910193834; Sat, 14 Jun 2025
 07:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749891128.git.mchehab+huawei@kernel.org> <440956b08faee14ed22575bea6c7b022666e5402.1749891128.git.mchehab+huawei@kernel.org>
In-Reply-To: <440956b08faee14ed22575bea6c7b022666e5402.1749891128.git.mchehab+huawei@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 15:09:42 +0100
X-Gm-Features: AX0GCFs5WsEnBPdhFzte8biCHZFUF6eei6nlpfaRN-4zu9Nw4kkNloOOYeoWy6E
Message-ID: <CAD4GDZzW3=m+SC53VvRX84=Sxd0uwxOb+ZdM2CRsztg2Xhu9=Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] tools: ynl_gen_rst.py: Split library from
 command line tool
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

On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> As we'll be using the Netlink specs parser inside a Sphinx
> extension, move the library part from the command line parser.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/netlink_yml_parser.py  | 391 +++++++++++++++++++++++++++++

As I mentioned earlier, please move this to tools/net/ynl/pyynl/lib

>  tools/net/ynl/pyynl/ynl_gen_rst.py | 374 +--------------------------
>  2 files changed, 401 insertions(+), 364 deletions(-)
>  create mode 100755 scripts/lib/netlink_yml_parser.py
>
> diff --git a/scripts/lib/netlink_yml_parser.py b/scripts/lib/netlink_yml_parser.py
> new file mode 100755
> index 000000000000..3c15b578f947
> --- /dev/null
> +++ b/scripts/lib/netlink_yml_parser.py
> @@ -0,0 +1,391 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# -*- coding: utf-8; mode: python -*-
> +
> +"""
> +    Script to auto generate the documentation for Netlink specifications.
> +
> +    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
> +    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
> +
> +    This script performs extensive parsing to the Linux kernel's netlink YAML
> +    spec files, in an effort to avoid needing to heavily mark up the original
> +    YAML file.
> +
> +    This code is split in three big parts:
> +        1) RST formatters: Use to convert a string to a RST output
> +        2) Parser helpers: Functions to parse the YAML data structure
> +        3) Main function and small helpers
> +"""
> +
> +from typing import Any, Dict, List
> +import os.path
> +import logging
> +import yaml
> +
> +
> +SPACE_PER_LEVEL = 4
> +
> +
> +# RST Formatters
> +# ==============
> +def headroom(level: int) -> str:
> +    """Return space to format"""
> +    return " " * (level * SPACE_PER_LEVEL)
> +
> +
> +def bold(text: str) -> str:
> +    """Format bold text"""
> +    return f"**{text}**"
> +
> +
> +def inline(text: str) -> str:
> +    """Format inline text"""
> +    return f"``{text}``"
> +
> +
> +def sanitize(text: str) -> str:
> +    """Remove newlines and multiple spaces"""
> +    # This is useful for some fields that are spread across multiple lines
> +    return str(text).replace("\n", " ").strip()
> +
> +
> +def rst_fields(key: str, value: str, level: int = 0) -> str:
> +    """Return a RST formatted field"""
> +    return headroom(level) + f":{key}: {value}"
> +
> +
> +def rst_definition(key: str, value: Any, level: int = 0) -> str:
> +    """Format a single rst definition"""
> +    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
> +
> +
> +def rst_paragraph(paragraph: str, level: int = 0) -> str:
> +    """Return a formatted paragraph"""
> +    return headroom(level) + paragraph
> +
> +
> +def rst_bullet(item: str, level: int = 0) -> str:
> +    """Return a formatted a bullet"""
> +    return headroom(level) + f"- {item}"
> +
> +
> +def rst_subsection(title: str) -> str:
> +    """Add a sub-section to the document"""
> +    return f"{title}\n" + "-" * len(title)
> +
> +
> +def rst_subsubsection(title: str) -> str:
> +    """Add a sub-sub-section to the document"""
> +    return f"{title}\n" + "~" * len(title)
> +
> +
> +def rst_section(namespace: str, prefix: str, title: str) -> str:
> +    """Add a section to the document"""
> +    return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
> +
> +
> +def rst_subtitle(title: str) -> str:
> +    """Add a subtitle to the document"""
> +    return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
> +
> +
> +def rst_title(title: str) -> str:
> +    """Add a title to the document"""
> +    return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
> +
> +
> +def rst_list_inline(list_: List[str], level: int = 0) -> str:
> +    """Format a list using inlines"""
> +    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
> +
> +
> +def rst_ref(namespace: str, prefix: str, name: str) -> str:
> +    """Add a hyperlink to the document"""
> +    mappings = {'enum': 'definition',
> +                'fixed-header': 'definition',
> +                'nested-attributes': 'attribute-set',
> +                'struct': 'definition'}
> +    if prefix in mappings:
> +        prefix = mappings[prefix]
> +    return f":ref:`{namespace}-{prefix}-{name}`"
> +
> +
> +def rst_header() -> str:
> +    """The headers for all the auto generated RST files"""
> +    lines = []
> +
> +    lines.append(rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
> +    lines.append(rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
> +
> +    return "\n".join(lines)
> +
> +
> +def rst_toctree(maxdepth: int = 2) -> str:
> +    """Generate a toctree RST primitive"""
> +    lines = []
> +
> +    lines.append(".. toctree::")
> +    lines.append(f"   :maxdepth: {maxdepth}\n\n")
> +
> +    return "\n".join(lines)
> +
> +
> +def rst_label(title: str) -> str:
> +    """Return a formatted label"""
> +    return f".. _{title}:\n\n"
> +
> +
> +# Parsers
> +# =======
> +
> +
> +def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
> +    """Parse 'multicast' group list and return a formatted string"""
> +    lines = []
> +    for group in mcast_group:
> +        lines.append(rst_bullet(group["name"]))
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
> +    """Parse 'do' section and return a formatted string"""
> +    lines = []
> +    for key in do_dict.keys():
> +        lines.append(rst_paragraph(bold(key), level + 1))
> +        if key in ['request', 'reply']:
> +            lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
> +        else:
> +            lines.append(headroom(level + 2) + do_dict[key] + "\n")
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
> +    """Parse 'attributes' section"""
> +    if "attributes" not in attrs:
> +        return ""
> +    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
> +    """Parse operations block"""
> +    preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
> +    linkable = ["fixed-header", "attribute-set"]
> +    lines = []
> +
> +    for operation in operations:
> +        lines.append(rst_section(namespace, 'operation', operation["name"]))
> +        lines.append(rst_paragraph(operation["doc"]) + "\n")
> +
> +        for key in operation.keys():
> +            if key in preprocessed:
> +                # Skip the special fields
> +                continue
> +            value = operation[key]
> +            if key in linkable:
> +                value = rst_ref(namespace, key, value)
> +            lines.append(rst_fields(key, value, 0))
> +        if 'flags' in operation:
> +            lines.append(rst_fields('flags', rst_list_inline(operation['flags'])))
> +
> +        if "do" in operation:
> +            lines.append(rst_paragraph(":do:", 0))
> +            lines.append(parse_do(operation["do"], 0))
> +        if "dump" in operation:
> +            lines.append(rst_paragraph(":dump:", 0))
> +            lines.append(parse_do(operation["dump"], 0))
> +
> +        # New line after fields
> +        lines.append("\n")
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
> +    """Parse a list of entries"""
> +    ignored = ["pad"]
> +    lines = []
> +    for entry in entries:
> +        if isinstance(entry, dict):
> +            # entries could be a list or a dictionary
> +            field_name = entry.get("name", "")
> +            if field_name in ignored:
> +                continue
> +            type_ = entry.get("type")
> +            if type_:
> +                field_name += f" ({inline(type_)})"
> +            lines.append(
> +                rst_fields(field_name, sanitize(entry.get("doc", "")), level)
> +            )
> +        elif isinstance(entry, list):
> +            lines.append(rst_list_inline(entry, level))
> +        else:
> +            lines.append(rst_bullet(inline(sanitize(entry)), level))
> +
> +    lines.append("\n")
> +    return "\n".join(lines)
> +
> +
> +def parse_definitions(defs: Dict[str, Any], namespace: str) -> str:
> +    """Parse definitions section"""
> +    preprocessed = ["name", "entries", "members"]
> +    ignored = ["render-max"]  # This is not printed
> +    lines = []
> +
> +    for definition in defs:
> +        lines.append(rst_section(namespace, 'definition', definition["name"]))
> +        for k in definition.keys():
> +            if k in preprocessed + ignored:
> +                continue
> +            lines.append(rst_fields(k, sanitize(definition[k]), 0))
> +
> +        # Field list needs to finish with a new line
> +        lines.append("\n")
> +        if "entries" in definition:
> +            lines.append(rst_paragraph(":entries:", 0))
> +            lines.append(parse_entries(definition["entries"], 1))
> +        if "members" in definition:
> +            lines.append(rst_paragraph(":members:", 0))
> +            lines.append(parse_entries(definition["members"], 1))
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_attr_sets(entries: List[Dict[str, Any]], namespace: str) -> str:
> +    """Parse attribute from attribute-set"""
> +    preprocessed = ["name", "type"]
> +    linkable = ["enum", "nested-attributes", "struct", "sub-message"]
> +    ignored = ["checks"]
> +    lines = []
> +
> +    for entry in entries:
> +        lines.append(rst_section(namespace, 'attribute-set', entry["name"]))
> +        for attr in entry["attributes"]:
> +            type_ = attr.get("type")
> +            attr_line = attr["name"]
> +            if type_:
> +                # Add the attribute type in the same line
> +                attr_line += f" ({inline(type_)})"
> +
> +            lines.append(rst_subsubsection(attr_line))
> +
> +            for k in attr.keys():
> +                if k in preprocessed + ignored:
> +                    continue
> +                if k in linkable:
> +                    value = rst_ref(namespace, k, attr[k])
> +                else:
> +                    value = sanitize(attr[k])
> +                lines.append(rst_fields(k, value, 0))
> +            lines.append("\n")
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_sub_messages(entries: List[Dict[str, Any]], namespace: str) -> str:
> +    """Parse sub-message definitions"""
> +    lines = []
> +
> +    for entry in entries:
> +        lines.append(rst_section(namespace, 'sub-message', entry["name"]))
> +        for fmt in entry["formats"]:
> +            value = fmt["value"]
> +
> +            lines.append(rst_bullet(bold(value)))
> +            for attr in ['fixed-header', 'attribute-set']:
> +                if attr in fmt:
> +                    lines.append(rst_fields(attr,
> +                                            rst_ref(namespace, attr, fmt[attr]),
> +                                            1))
> +            lines.append("\n")
> +
> +    return "\n".join(lines)
> +
> +
> +def parse_yaml(obj: Dict[str, Any]) -> str:
> +    """Format the whole YAML into a RST string"""
> +    lines = []
> +
> +    # Main header
> +
> +    family = obj['name']
> +
> +    lines.append(rst_header())
> +    lines.append(rst_label("netlink-" + family))
> +
> +    title = f"Family ``{family}`` netlink specification"
> +    lines.append(rst_title(title))
> +    lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
> +
> +    if "doc" in obj:
> +        lines.append(rst_subtitle("Summary"))
> +        lines.append(rst_paragraph(obj["doc"], 0))
> +
> +    # Operations
> +    if "operations" in obj:
> +        lines.append(rst_subtitle("Operations"))
> +        lines.append(parse_operations(obj["operations"]["list"], family))
> +
> +    # Multicast groups
> +    if "mcast-groups" in obj:
> +        lines.append(rst_subtitle("Multicast groups"))
> +        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
> +
> +    # Definitions
> +    if "definitions" in obj:
> +        lines.append(rst_subtitle("Definitions"))
> +        lines.append(parse_definitions(obj["definitions"], family))
> +
> +    # Attributes set
> +    if "attribute-sets" in obj:
> +        lines.append(rst_subtitle("Attribute sets"))
> +        lines.append(parse_attr_sets(obj["attribute-sets"], family))
> +
> +    # Sub-messages
> +    if "sub-messages" in obj:
> +        lines.append(rst_subtitle("Sub-messages"))
> +        lines.append(parse_sub_messages(obj["sub-messages"], family))
> +
> +    return "\n".join(lines)
> +
> +
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
> +SRC_DIR = os.path.dirname(os.path.realpath(__file__))
>
> -SPACE_PER_LEVEL = 4
> +sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
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

This would be easier to review if this patch was only the code move,
without unrelated code changes.

>      with open(filename, "w", encoding="utf-8") as rst_file:
>          rst_file.write(content)
>
>
> -def generate_main_index_rst(output: str, index_dir: str) -> None:
> +def write_index_rst(output: str, index_dir: str) -> None:

It would simplify the patch series if we can avoid refactoring
generate_main_index_rst when it needs to be removed. Can you remove
the code earlier in the series?

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
>
>
>  if __name__ == "__main__":
> --
> 2.49.0
>

