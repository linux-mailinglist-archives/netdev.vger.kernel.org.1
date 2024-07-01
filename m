Return-Path: <netdev+bounces-108192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE791E4A8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D18C2816E0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5AF16D4E5;
	Mon,  1 Jul 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C42+A4uC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907E16D9CC
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849025; cv=none; b=SDgLO1QfrRZOgR2tw6ifmDszZLgrNo3J6tNzhQV8WifEsE/+aMvZ6X6qnE1AYjWvpI4Q/mnpmMy2B/EbX2my3m/UM51l3ZYyE8QaqjHI/+uYMLtKycBSVEak1xKXPZ9jwKPEJGfSaBmlYSa6Mktr7Z5nGAC8hgAQg/XpvR64Pps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849025; c=relaxed/simple;
	bh=06FQjj19sJC+dFDK1d/WcOkMy2enXvxRAcsaoKT5zmY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AREJxMX3/xhuvol8gRluewcaGaBuA6cfBh9qi7GM5KKYpfGcCis9b9oI3d4a3U5lqPubhsObnQHKIeRavWC8I/lbLLNIRsby+9HVo6+QQyE5drDhT+HBFCX4FVGMmqmwOq1xr3WYuxNaLPqU/Woj6qvhGLnDuOOi8gx7DwvNXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C42+A4uC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719849022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZDy3yb111GlG94IrRgdaL/NessBspWcv6lh8LsmJDQ=;
	b=C42+A4uC3Kw0xLIz9re7z45uZB25Pg1Lvd2jIZhnrvzn6lJqBm1e8/gXna9Qc+/3uOUVTf
	nJNMEeeG51fkRsnGjpzUn1J+dUK1/AZG5Sl0D/os7JCwuGk1bJNhSxIRrAID8qJmXh7Rlw
	O9j5zy8UGarsU7Mz+/gCfTGTi/tHBtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-H8myNKEwPGCn7WB_XRnSpQ-1; Mon, 01 Jul 2024 11:50:21 -0400
X-MC-Unique: H8myNKEwPGCn7WB_XRnSpQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-424a5825227so5428105e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 08:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719849020; x=1720453820;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZDy3yb111GlG94IrRgdaL/NessBspWcv6lh8LsmJDQ=;
        b=t+J1BjO+Yrnet1RJJintQxihAPUPyHtSsEPn41x5xHD6+a3hiPO+5yvvMWtyyIc+6K
         LRGYEvGbcemQpeFBu0gDBSZGa3ELDAPg5OKsaZynLrOJdua2fwe7Y8+a1PR5GMY6atjP
         Ab6QfgqYUHEJPyiOo1/4nD5encbbqP61j9GQvAqKnKWv5OqZO/WvOwvTSHyVOnO4wl9P
         CDQQ4tlqjNuBw4DV3yTbb1b0P+DntqbmI/9nv+n0m5H6u1VQSIxXZM18Nemzdqxzg/HC
         bv68GGCIcSQbAGT4BEkWtjvErqsG3yMt+vOUKc+UQbHVzAjJzT1xjEnPr8hZ4H4ywLN1
         hl4Q==
X-Gm-Message-State: AOJu0YzeVw08mvosmyD0q8b2Uaid1FHKtlZCfCHjMz17geTnzGrX+pxW
	FxEn4uJLVycx89EpEKwcgMrInGZF7iLw+tNJciGovBn7x3rG7h6gKopPwBGRsHfYfqAD0jWGceI
	cN6ji0txOYJYGZc4UmSOK+ZqDd7187ICFwiy+kD9gjb/VQTH4O38QoQ==
X-Received: by 2002:a05:6000:1445:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-367757214d5mr3448495f8f.3.1719849020093;
        Mon, 01 Jul 2024 08:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcZ2FBg+ssPQfagc8jfh9mTNXbDOkT+5OrF/ndajFMVDTtXEdgwvkN6qFhD9tcQR6rBlG5Gw==
X-Received: by 2002:a05:6000:1445:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-367757214d5mr3448482f8f.3.1719849019616;
        Mon, 01 Jul 2024 08:50:19 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2451:6610::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd4a1sm10410709f8f.23.2024.07.01.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:50:19 -0700 (PDT)
Message-ID: <ce6eff278a2df55fbdadf7fd3af7b1d9bd7f50a2.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 01 Jul 2024 17:50:17 +0200
In-Reply-To: <db537cf129f23b012d09f7067146c4daee31cf4c.camel@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
	 <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	 <20240628191230.138c66d7@kernel.org>
	 <db537cf129f23b012d09f7067146c4daee31cf4c.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 16:50 +0200, Paolo Abeni wrote:
> On Fri, 2024-06-28 at 19:12 -0700, Jakub Kicinski wrote:
> > On Thu, 27 Jun 2024 22:17:18 +0200 Paolo Abeni wrote:
> >=20
> > > +attribute-sets:
> > > +  -
> > > +    name: net_shaper
> >=20
> > s/_/-/ on all names
>=20
> It looks like the initial
>=20
> name: net_shaper
>=20
> would require some patching to ynl-gen-c.py to handle the s/_/-/
> conversion in the generated file names, too.

I mean something alike the following, to be explicit:
---
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 374ca5e86e24..51529fabd517 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -59,9 +59,9 @@ class Type(SpecAttr):
         if 'nested-attributes' in attr:
             self.nested_attrs =3D attr['nested-attributes']
             if self.nested_attrs =3D=3D family.name:
-                self.nested_render_name =3D c_lower(f"{family.name}")
+                self.nested_render_name =3D c_lower(f"{family.ident_name}"=
)
             else:
-                self.nested_render_name =3D c_lower(f"{family.name}_{self.=
nested_attrs}")
+                self.nested_render_name =3D c_lower(f"{family.ident_name}_=
{self.nested_attrs}")
=20
             if self.nested_attrs in self.family.consts:
                 self.nested_struct_type =3D 'struct ' + self.nested_render=
_name + '_'
@@ -693,9 +693,9 @@ class Struct:
=20
         self.nested =3D type_list is None
         if family.name =3D=3D c_lower(space_name):
-            self.render_name =3D c_lower(family.name)
+            self.render_name =3D c_lower(family.ident_name)
         else:
-            self.render_name =3D c_lower(family.name + '-' + space_name)
+            self.render_name =3D c_lower(family.ident_name + '-' + space_n=
ame)
         self.struct_name =3D 'struct ' + self.render_name
         if self.nested and space_name in family.consts:
             self.struct_name +=3D '_'
@@ -761,7 +761,7 @@ class EnumEntry(SpecEnumEntry):
=20
 class EnumSet(SpecEnumSet):
     def __init__(self, family, yaml):
-        self.render_name =3D c_lower(family.name + '-' + yaml['name'])
+        self.render_name =3D c_lower(family.ident_name + '-' + yaml['name'=
])
=20
         if 'enum-name' in yaml:
             if yaml['enum-name']:
@@ -777,7 +777,7 @@ class EnumSet(SpecEnumSet):
         else:
             self.user_type =3D 'int'
=20
-        self.value_pfx =3D yaml.get('name-prefix', f"{family.name}-{yaml['=
name']}-")
+        self.value_pfx =3D yaml.get('name-prefix', f"{family.ident_name}-{=
yaml['name']}-")
=20
         super().__init__(family, yaml)
=20
@@ -802,9 +802,9 @@ class AttrSet(SpecAttrSet):
             if 'name-prefix' in yaml:
                 pfx =3D yaml['name-prefix']
             elif self.name =3D=3D family.name:
-                pfx =3D family.name + '-a-'
+                pfx =3D family.ident_name + '-a-'
             else:
-                pfx =3D f"{family.name}-a-{self.name}-"
+                pfx =3D f"{family.ident_name}-a-{self.name}-"
             self.name_prefix =3D c_upper(pfx)
             self.max_name =3D c_upper(self.yaml.get('attr-max-name', f"{se=
lf.name_prefix}max"))
             self.cnt_name =3D c_upper(self.yaml.get('attr-cnt-name', f"__{=
self.name_prefix}max"))
@@ -861,7 +861,7 @@ class Operation(SpecOperation):
     def __init__(self, family, yaml, req_value, rsp_value):
         super().__init__(family, yaml, req_value, rsp_value)
=20
-        self.render_name =3D c_lower(family.name + '_' + self.name)
+        self.render_name =3D c_lower(family.ident_name + '_' + self.name)
=20
         self.dual_policy =3D ('do' in yaml and 'request' in yaml['do']) an=
d \
                          ('dump' in yaml and 'request' in yaml['dump'])
@@ -911,11 +911,11 @@ class Family(SpecFamily):
         if 'uapi-header' in self.yaml:
             self.uapi_header =3D self.yaml['uapi-header']
         else:
-            self.uapi_header =3D f"linux/{self.name}.h"
+            self.uapi_header =3D f"linux/{self.ident_name}.h"
         if self.uapi_header.startswith("linux/") and self.uapi_header.ends=
with('.h'):
             self.uapi_header_name =3D self.uapi_header[6:-2]
         else:
-            self.uapi_header_name =3D self.name
+            self.uapi_header_name =3D self.ident_name
=20
     def resolve(self):
         self.resolve_up(super())
@@ -923,7 +923,7 @@ class Family(SpecFamily):
         if self.yaml.get('protocol', 'genetlink') not in {'genetlink', 'ge=
netlink-c', 'genetlink-legacy'}:
             raise Exception("Codegen only supported for genetlink")
=20
-        self.c_name =3D c_lower(self.name)
+        self.c_name =3D c_lower(self.ident_name)
         if 'name-prefix' in self.yaml['operations']:
             self.op_prefix =3D c_upper(self.yaml['operations']['name-prefi=
x'])
         else:
@@ -2173,7 +2173,7 @@ def print_kernel_op_table_fwd(family, cw, terminate):
     exported =3D not kernel_can_gen_family_struct(family)
=20
     if not terminate or exported:
-        cw.p(f"/* Ops table for {family.name} */")
+        cw.p(f"/* Ops table for {family.ident_name} */")
=20
         pol_to_struct =3D {'global': 'genl_small_ops',
                          'per-op': 'genl_ops',
@@ -2225,12 +2225,12 @@ def print_kernel_op_table_fwd(family, cw, terminate=
):
             continue
=20
         if 'do' in op:
-            name =3D c_lower(f"{family.name}-nl-{op_name}-doit")
+            name =3D c_lower(f"{family.ident_name}-nl-{op_name}-doit")
             cw.write_func_prot('int', name,
                                ['struct sk_buff *skb', 'struct genl_info *=
info'], suffix=3D';')
=20
         if 'dump' in op:
-            name =3D c_lower(f"{family.name}-nl-{op_name}-dumpit")
+            name =3D c_lower(f"{family.ident_name}-nl-{op_name}-dumpit")
             cw.write_func_prot('int', name,
                                ['struct sk_buff *skb', 'struct netlink_cal=
lback *cb'], suffix=3D';')
     cw.nl()
@@ -2256,13 +2256,13 @@ def print_kernel_op_table(family, cw):
                                             for x in op['dont-validate']])=
), )
             for op_mode in ['do', 'dump']:
                 if op_mode in op:
-                    name =3D c_lower(f"{family.name}-nl-{op_name}-{op_mode=
}it")
+                    name =3D c_lower(f"{family.ident_name}-nl-{op_name}-{o=
p_mode}it")
                     members.append((op_mode + 'it', name))
             if family.kernel_policy =3D=3D 'per-op':
                 struct =3D Struct(family, op['attribute-set'],
                                 type_list=3Dop['do']['request']['attribute=
s'])
=20
-                name =3D c_lower(f"{family.name}-{op_name}-nl-policy")
+                name =3D c_lower(f"{family.ident_name}-{op_name}-nl-policy=
")
                 members.append(('policy', name))
                 members.append(('maxattr', struct.attr_max_val.enum_name))
             if 'flags' in op:
@@ -2294,7 +2294,7 @@ def print_kernel_op_table(family, cw):
                         members.append(('validate',
                                         ' | '.join([c_upper('genl-dont-val=
idate-' + x)
                                                     for x in dont_validate=
])), )
-                name =3D c_lower(f"{family.name}-nl-{op_name}-{op_mode}it"=
)
+                name =3D c_lower(f"{family.ident_name}-nl-{op_name}-{op_mo=
de}it")
                 if 'pre' in op[op_mode]:
                     members.append((cb_names[op_mode]['pre'], c_lower(op[o=
p_mode]['pre'])))
                 members.append((op_mode + 'it', name))
@@ -2305,9 +2305,9 @@ def print_kernel_op_table(family, cw):
                                     type_list=3Dop[op_mode]['request']['at=
tributes'])
=20
                     if op.dual_policy:
-                        name =3D c_lower(f"{family.name}-{op_name}-{op_mod=
e}-nl-policy")
+                        name =3D c_lower(f"{family.ident_name}-{op_name}-{=
op_mode}-nl-policy")
                     else:
-                        name =3D c_lower(f"{family.name}-{op_name}-nl-poli=
cy")
+                        name =3D c_lower(f"{family.ident_name}-{op_name}-n=
l-policy")
                     members.append(('policy', name))
                     members.append(('maxattr', struct.attr_max_val.enum_na=
me))
                 flags =3D (op['flags'] if 'flags' in op else []) + ['cmd-c=
ap-' + op_mode]
@@ -2326,7 +2326,7 @@ def print_kernel_mcgrp_hdr(family, cw):
=20
     cw.block_start('enum')
     for grp in family.mcgrps['list']:
-        grp_id =3D c_upper(f"{family.name}-nlgrp-{grp['name']},")
+        grp_id =3D c_upper(f"{family.ident_name}-nlgrp-{grp['name']},")
         cw.p(grp_id)
     cw.block_end(';')
     cw.nl()
@@ -2339,7 +2339,7 @@ def print_kernel_mcgrp_src(family, cw):
     cw.block_start('static const struct genl_multicast_group ' + family.c_=
name + '_nl_mcgrps[] =3D')
     for grp in family.mcgrps['list']:
         name =3D grp['name']
-        grp_id =3D c_upper(f"{family.name}-nlgrp-{name}")
+        grp_id =3D c_upper(f"{family.ident_name}-nlgrp-{name}")
         cw.p('[' + grp_id + '] =3D { "' + name + '", },')
     cw.block_end(';')
     cw.nl()
@@ -2361,7 +2361,7 @@ def print_kernel_family_struct_src(family, cw):
     if not kernel_can_gen_family_struct(family):
         return
=20
-    cw.block_start(f"struct genl_family {family.name}_nl_family __ro_after=
_init =3D")
+    cw.block_start(f"struct genl_family {family.ident_name}_nl_family __ro=
_after_init =3D")
     cw.p('.name\t\t=3D ' + family.fam_key + ',')
     cw.p('.version\t=3D ' + family.ver_key + ',')
     cw.p('.netnsok\t=3D true,')
@@ -2429,7 +2429,7 @@ def render_uapi(family, cw):
                 cw.p(' */')
=20
             uapi_enum_start(family, cw, const, 'name')
-            name_pfx =3D const.get('name-prefix', f"{family.name}-{const['=
name']}-")
+            name_pfx =3D const.get('name-prefix', f"{family.ident_name}-{c=
onst['name']}-")
             for entry in enum.entries.values():
                 suffix =3D ','
                 if entry.value_change:
@@ -2451,7 +2451,7 @@ def render_uapi(family, cw):
             cw.nl()
         elif const['type'] =3D=3D 'const':
             defines.append([c_upper(family.get('c-define-name',
-                                               f"{family.name}-{const['nam=
e']}")),
+                                               f"{family.ident_name}-{cons=
t['name']}")),
                             const['value']])
=20
     if defines:
@@ -2529,7 +2529,7 @@ def render_uapi(family, cw):
     defines =3D []
     for grp in family.mcgrps['list']:
         name =3D grp['name']
-        defines.append([c_upper(grp.get('c-define-name', f"{family.name}-m=
cgrp-{name}")),
+        defines.append([c_upper(grp.get('c-define-name', f"{family.ident_n=
ame}-mcgrp-{name}")),
                         f'{name}'])
     cw.nl()
     if defines:



