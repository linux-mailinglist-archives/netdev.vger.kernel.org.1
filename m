Return-Path: <netdev+bounces-21651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C67641D2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C9281FA0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3018044;
	Wed, 26 Jul 2023 22:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010431BF04
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:01:27 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B9211C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:01:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b9e9765f2cso1891865ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690408885; x=1691013685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPO0lNo7EtBoDjUIbm+hlaYeLGktUlocDKNxXWN7Lq0=;
        b=S0X6v/nU+OtqTGy0DKrTcfZRpBMq8PvQULDvv+538zevQb5LF3H4buERXwycGotJ2G
         ZVhqO5greIxoROHL76Y9tkPMmfQpUr6i98/iAl3joH8orn3CrrOlwVFVNv4Ec/9Zz/1b
         HUOMJd9UPeMGzVjhiCGdIN2s4RlTCjaTX3+rYz7tso2JpkX9hmZDOm3Dj7LV7C4iOO3W
         cyhYv9An/A/5aju9TBIpPdYy/LUsayPtRj2OX/lo08XmJR/GwJuzB6vtg84SkKmCLs04
         tkmS9q0d9FvjTyvnRUmAuCqul9FQaQxuF/30jA+Ret3MvQzGLUwz+b5Ve8+7gSxeD15f
         4Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408885; x=1691013685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPO0lNo7EtBoDjUIbm+hlaYeLGktUlocDKNxXWN7Lq0=;
        b=U82SJ9iv0g3o5ylIvWStXDEJCYok+AuwkhVKBrkxO3ZadX6hD5VEyXJvXnBszh+Im5
         RHuypntoont/z3ExgHwOhl1NfrvcHTast/KNXyqkYM5ubGLic58B64PmswxvwyTYAyAl
         fKtxdmGden68+F/rfbEIc8kr+sVmsW2ZRL1XeZKKSd2A/HNCzKVfwL/lx2yvemk1EPlC
         pEQhiYLMJBEnEjc6lxJmrwGGVUCFT14Hh71Rc1g2t7ASvvA2ZNomAeI7Ve/q/seww4bp
         213EBXreKjZs5kYqzKdy56GfV8oZY3WfKNlr0AO6uKQ6nquZW8ws+sXZ9baHb2kWdObQ
         9vXw==
X-Gm-Message-State: ABy/qLZp/exjhQirm/TCMC61wZriPyrlhUcr64J+atB12uJ189SbrJn1
	qSvHWyRVpXFQVyUWBUBEgjPlvPvVVNQheSoXrYY=
X-Google-Smtp-Source: APBJJlFyTYd1wmn4PepePwSBfDp8PILFtX8qsj9f/S8MPpDC0AuleVoaobP9eL5U4bFJ2Y5FO6th8J0c2dhtO4tJuW4=
X-Received: by 2002:a17:90a:d155:b0:263:4685:f9a5 with SMTP id
 t21-20020a17090ad15500b002634685f9a5mr2818107pjw.8.1690408884419; Wed, 26 Jul
 2023 15:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725162205.27526-1-donald.hunter@gmail.com>
 <20230725162205.27526-3-donald.hunter@gmail.com> <20230726143709.791169dd@kernel.org>
In-Reply-To: <20230726143709.791169dd@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 26 Jul 2023 23:01:12 +0100
Message-ID: <CAD4GDZw=CoHXbTn_AR1h2YUnn92K_JVj+ACAKH670PWRrJ+_pA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/3] tools/net/ynl: Add support for
 netlink-raw families
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 22:37, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 25 Jul 2023 17:22:04 +0100 Donald Hunter wrote:
> > Refactor the ynl code to encapsulate protocol-family specifics into
> > NetlinkProtocolFamily and GenlProtocolFamily.
>
> > +class SpecMcastGroup(SpecElement):
> > +    """Netlink Multicast Group
> > +
> > +    Information about a multicast group.
> > +
> > +    Attributes:
> > +        id        numerical id of this multicast group for netlink-raw
> > +        yaml      raw spec as loaded from the spec file
> > +    """
> > +    def __init__(self, family, yaml):
> > +        super().__init__(family, yaml)
> > +        self.id = self.yaml.get('id')
>
> name, too?

Ack.

> > +        mcgs = self.yaml.get('mcast-groups')
> > +        if mcgs:
> > +            for elem in mcgs['list']:
> > +                mcg = self.new_mcast_group(elem)
> > +                self.mcast_groups[elem['name']] = mcg
>
> Could you factor out the mcgroup changes to a separate patch?

Will do.

> > diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> > index 3e2ade2194cd..7e877c43e10f 100644
> > --- a/tools/net/ynl/lib/ynl.py
> > +++ b/tools/net/ynl/lib/ynl.py
> > @@ -25,6 +25,7 @@ class Netlink:
> >      NETLINK_ADD_MEMBERSHIP = 1
> >      NETLINK_CAP_ACK = 10
> >      NETLINK_EXT_ACK = 11
> > +    NETLINK_GET_STRICT_CHK = 12
> >
> >      # Netlink message
> >      NLMSG_ERROR = 2
> > @@ -153,6 +154,21 @@ class NlAttr:
> >              value[m.name] = decoded
> >          return value
> >
> > +    @classmethod
> > +    def decode_enum(cls, raw, attr_spec, consts):
> > +        enum = consts[attr_spec['enum']]
> > +        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
> > +            i = 0
> > +            value = set()
> > +            while raw:
> > +                if raw & 1:
> > +                    value.add(enum.entries_by_val[i].name)
> > +                raw >>= 1
> > +                i += 1
> > +        else:
> > +            value = enum.entries_by_val[raw].name
> > +        return value
>
> This doesn't always operates on netlink attributes, technically,
> so how about we make it a standalone function, not a member of NlAttr?
> Or should we move it to a parent class, NetlinkProtocolFamily?

Fair point. I'll maybe go for standalone just now but will think on
it some more first.

>
> > +    def decode_fixed_header(self, consts, op):
> > +        fixed_header_members = consts[op.fixed_header].members
> > +        self.fixed_header_attrs = dict()
> > +        offset = 0
> > +        for m in fixed_header_members:
> > +            format = NlAttr.get_format(m.type, m.byte_order)
> > +            [ value ] = format.unpack_from(self.raw, offset)
> > +            offset += format.size
> > +
> > +            if m.enum:
> > +                value = NlAttr.decode_enum(value, m, consts)
> > +
> > +            self.fixed_header_attrs[m.name] = value
> > +        self.raw = self.raw[offset:]
> > +
> > +    def cmd(self):
> > +        return self.nl_type
>
> And perhaps the pure code moves could be a separate patch for ease
> of review?

Ack.

> >      def __repr__(self):
> >          msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
> >          if self.error:
> > @@ -318,23 +353,21 @@ def _genl_load_families():
> >
> >
> >  class GenlMsg:
> > -    def __init__(self, nl_msg, fixed_header_members=[]):
> > -        self.nl = nl_msg
> > +    def __init__(self, nl_msg, ynl=None):
> > +        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
> > +        nl_msg.raw = nl_msg.raw[4:]
> >
> > -        self.hdr = nl_msg.raw[0:4]
> > -        offset = 4
> > +        if ynl:
> > +            op = ynl.rsp_by_value[self.genl_cmd]
>
> Took me a while to figure out why ynl gets passed here :S
> I'm not sure what the best structure of inheritance is but
> I think we should at the very least *not* call genl vs raw-nl
> "family".
>
> NetlinkProtocolFamily -> NetlinkProtocol
> GenlProtocolFamily -> GenlProtocol

Yeah, agreed. "Family" is way too overloaded already :-)

> and store them in YnlFamily to self.nlproto or self.protocol
> or some such.

Ack. Just a note that I have been wondering about refactoring this
from "YnlFamily is a Spec" to "Ynl has n Specs" so that we could do
multi spec notification handling. If we did this, then passing a
SpecContext around would look more natural maybe.

> > +            if op.fixed_header:
> > +                nl_msg.decode_fixed_header(ynl.consts, op)
>
> >      def _decode_binary(self, attr, attr_spec):
> >          if attr_spec.struct_name:
> >              members = self.consts[attr_spec.struct_name]
> > -            decoded = attr.as_struct(members)
> > +            decoded = attr.as_struct(members, self.consts)
>
> I applied the series on top of Arkadiusz's fixes and this line throws
> an "as_struct takes 2 arguments, 3 given" exception.

Ah, my bad. Looks like I missed a fix for that from the patchset.

> >              for m in members:
> >                  if m.enum:
> >                       decoded[m.name] = self._decode_enum(decoded[m.name], m)
>

