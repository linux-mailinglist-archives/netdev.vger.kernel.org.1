Return-Path: <netdev+bounces-21645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B776414B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BC11C2147D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BB11BF1D;
	Wed, 26 Jul 2023 21:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE891BEEA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA4C433C7;
	Wed, 26 Jul 2023 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407430;
	bh=dTO1TCXCc3C5QkLMYbYAgfBJOTZoSw3d99NQ5//zOFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/ohuGqlKPefwlGw6ZuKFdDxb/98ojxp5fUnnIpEHQ13a25AQ6ocx1iosBEyZeLxj
	 msiwK/HzpgViipQ9bi0IlPskEtqfUcnG9i3fPfnBIx5hNN4yNi4LaDmGFmARMg1cu3
	 s2C+6RvAT6+8KKl3xnCMNDbC3rlYAvJQ7DJtkwD1g+zz8P38Ej5/b5iejjFiR9D2jj
	 I79NDC9Qj+g1z+foqOlTer0B1zlvgm+pYx34z4UQdWorE9h7KYeRp0ZnZBc0N9NALb
	 1cuoVaSCDtdDPn8p/2aQvoOvdI3n3tHD/Nfo4pZr2+MwmZySi6cFt2iJ0WWcgu+ANr
	 g0rit5Sy8gMsw==
Date: Wed, 26 Jul 2023 14:37:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/3] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230726143709.791169dd@kernel.org>
In-Reply-To: <20230725162205.27526-3-donald.hunter@gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
	<20230725162205.27526-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 17:22:04 +0100 Donald Hunter wrote:
> Refactor the ynl code to encapsulate protocol-family specifics into
> NetlinkProtocolFamily and GenlProtocolFamily.

> +class SpecMcastGroup(SpecElement):
> +    """Netlink Multicast Group
> +
> +    Information about a multicast group.
> +
> +    Attributes:
> +        id        numerical id of this multicast group for netlink-raw
> +        yaml      raw spec as loaded from the spec file
> +    """
> +    def __init__(self, family, yaml):
> +        super().__init__(family, yaml)
> +        self.id = self.yaml.get('id')

name, too?

>  class SpecFamily(SpecElement):
>      """ Netlink Family Spec class.
>  
> @@ -343,6 +357,7 @@ class SpecFamily(SpecElement):
>          ntfs       dict of all async events
>          consts     dict of all constants/enums
>          fixed_header  string, optional name of family default fixed header struct
> +        mcast_groups  dict of all multicast groups (index by name)
>      """
>      def __init__(self, spec_path, schema_path=None, exclude_ops=None):
>          with open(spec_path, "r") as stream:
> @@ -384,6 +399,7 @@ class SpecFamily(SpecElement):
>          self.ops = collections.OrderedDict()
>          self.ntfs = collections.OrderedDict()
>          self.consts = collections.OrderedDict()
> +        self.mcast_groups = collections.OrderedDict()
>  
>          last_exception = None
>          while len(self._resolution_list) > 0:
> @@ -416,6 +432,9 @@ class SpecFamily(SpecElement):
>      def new_operation(self, elem, req_val, rsp_val):
>          return SpecOperation(self, elem, req_val, rsp_val)
>  
> +    def new_mcast_group(self, elem):
> +        return SpecMcastGroup(self, elem)
> +
>      def add_unresolved(self, elem):
>          self._resolution_list.append(elem)
>  
> @@ -512,3 +531,9 @@ class SpecFamily(SpecElement):
>                  self.ops[op.name] = op
>              elif op.is_async:
>                  self.ntfs[op.name] = op
> +
> +        mcgs = self.yaml.get('mcast-groups')
> +        if mcgs:
> +            for elem in mcgs['list']:
> +                mcg = self.new_mcast_group(elem)
> +                self.mcast_groups[elem['name']] = mcg

Could you factor out the mcgroup changes to a separate patch?

> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 3e2ade2194cd..7e877c43e10f 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -25,6 +25,7 @@ class Netlink:
>      NETLINK_ADD_MEMBERSHIP = 1
>      NETLINK_CAP_ACK = 10
>      NETLINK_EXT_ACK = 11
> +    NETLINK_GET_STRICT_CHK = 12
>  
>      # Netlink message
>      NLMSG_ERROR = 2
> @@ -153,6 +154,21 @@ class NlAttr:
>              value[m.name] = decoded
>          return value
>  
> +    @classmethod
> +    def decode_enum(cls, raw, attr_spec, consts):
> +        enum = consts[attr_spec['enum']]
> +        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
> +            i = 0
> +            value = set()
> +            while raw:
> +                if raw & 1:
> +                    value.add(enum.entries_by_val[i].name)
> +                raw >>= 1
> +                i += 1
> +        else:
> +            value = enum.entries_by_val[raw].name
> +        return value

This doesn't always operates on netlink attributes, technically,
so how about we make it a standalone function, not a member of NlAttr?
Or should we move it to a parent class, NetlinkProtocolFamily?

> +    def decode_fixed_header(self, consts, op):
> +        fixed_header_members = consts[op.fixed_header].members
> +        self.fixed_header_attrs = dict()
> +        offset = 0
> +        for m in fixed_header_members:
> +            format = NlAttr.get_format(m.type, m.byte_order)
> +            [ value ] = format.unpack_from(self.raw, offset)
> +            offset += format.size
> +
> +            if m.enum:
> +                value = NlAttr.decode_enum(value, m, consts)
> +
> +            self.fixed_header_attrs[m.name] = value
> +        self.raw = self.raw[offset:]
> +
> +    def cmd(self):
> +        return self.nl_type

And perhaps the pure code moves could be a separate patch for ease 
of review?

>      def __repr__(self):
>          msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
>          if self.error:
> @@ -318,23 +353,21 @@ def _genl_load_families():
>  
>  
>  class GenlMsg:
> -    def __init__(self, nl_msg, fixed_header_members=[]):
> -        self.nl = nl_msg
> +    def __init__(self, nl_msg, ynl=None):
> +        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
> +        nl_msg.raw = nl_msg.raw[4:]
>  
> -        self.hdr = nl_msg.raw[0:4]
> -        offset = 4
> +        if ynl:
> +            op = ynl.rsp_by_value[self.genl_cmd]

Took me a while to figure out why ynl gets passed here :S
I'm not sure what the best structure of inheritance is but
I think we should at the very least *not* call genl vs raw-nl
"family".

NetlinkProtocolFamily -> NetlinkProtocol
GenlProtocolFamily -> GenlProtocol

and store them in YnlFamily to self.nlproto or self.protocol
or some such.

> +            if op.fixed_header:
> +                nl_msg.decode_fixed_header(ynl.consts, op)

>      def _decode_binary(self, attr, attr_spec):
>          if attr_spec.struct_name:
>              members = self.consts[attr_spec.struct_name]
> -            decoded = attr.as_struct(members)
> +            decoded = attr.as_struct(members, self.consts)

I applied the series on top of Arkadiusz's fixes and this line throws
an "as_struct takes 2 arguments, 3 given" exception.

>              for m in members:
>                  if m.enum:
>                       decoded[m.name] = self._decode_enum(decoded[m.name], m)


