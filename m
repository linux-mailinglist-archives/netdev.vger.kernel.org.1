Return-Path: <netdev+bounces-285800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMNQGNLY/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BACEC4F66D8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D3C530247C2
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBC3BAD9B;
	Fri,  8 May 2026 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyEb0Axs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAA3DC4C1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243773; cv=none; b=Gak/vcdFZGR6X1JCiPdHh9IImiq4DKmYlmTCIeKoirj7ZniOy9EHNxOM08oi2Z9veZjjbl8WC7TWr7HjDmw6URwbE5tC9pxMoCNYBVG2Zlkujm/S4QiXbb3SiST+wdZ43Xc6wZHsrl337a/9xX4g7w3FKTq3smk9qiEaa9NFa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243773; c=relaxed/simple;
	bh=3xxbKM8vbG08j740C7iq/B/wbeWFQxySna8jLsk8rXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vj6vKzWdSzxXhj6V5Z72aOZW5FTZ+m3/J07NjD5UAa3IfOjw7zOFEStyCh2m9flBlsLrBUCboNdtAdFVnXbJAQ8jUiTnPsz1Y5uSkkXgUQDes/uILGou7jp8++SsUkzH58n+SfwuZcnJbz6gR7d78GjGIJnXWtYin/VLNQJqIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyEb0Axs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778243770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4CFvEVAz8m7sZ6g46baskyZcaIYwuKamZfrB4xYmx+Q=;
	b=VyEb0AxsoTFurLtbouop9+ph75XiX9jYU/Z/AaoJ9/+UuKTfJ3y87CZTma5hwrFiHlPAmB
	SPxfukRBq0YYNWB1sJ7/6VaY/R6h5h/HNKb05x0xLnPihPXe8GCFqLTKGXaaTidAQG32I2
	3j9/Yvllpupj2PHWFhgRcGjR7DrKAh4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-bf-H66GlNUycITeye1H2Og-1; Fri,
 08 May 2026 08:36:06 -0400
X-MC-Unique: bf-H66GlNUycITeye1H2Og-1
X-Mimecast-MFC-AGG-ID: bf-H66GlNUycITeye1H2Og_1778243765
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD94619560BB;
	Fri,  8 May 2026 12:36:04 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 121451944B20;
	Fri,  8 May 2026 12:36:01 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] selftests: openvswitch: add vlan() and
 encap() flow string parsing
In-Reply-To: <20260507131541.2331771-2-houminxi@gmail.com> (Minxi Hou's
	message of "Thu, 7 May 2026 21:15:40 +0800")
References: <20260507131541.2331771-1-houminxi@gmail.com>
	<20260507131541.2331771-2-houminxi@gmail.com>
Date: Fri, 08 May 2026 08:36:00 -0400
Message-ID: <f7tlddurscv.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: BACEC4F66D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285800-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Minxi Hou <houminxi@gmail.com> writes:

> Add VLAN TCI formatting and parsing support to ovs-dpctl.py:
>
> - Add _vlan_dpstr() to decompose TCI into vid/pcp/cfi fields,
>   with raw tci=0x%04x fallback when cfi=0 for round-trip safety.
> - Add _parse_vlan_from_flowstr() boundary check for missing ')'.
> - Add encap_ovskey subclass restricting nla_map to L2-L4 attributes
>   (slots 0-21) that appear inside 802.1Q ENCAP, with metadata
>   attributes set to "none".
> - Check parse() return value for unrecognized trailing content.
> - Support callable format functions in dpstr() output.
> - Change OVS_KEY_ATTR_VLAN type from uint16 to be16 to match the
>   kernel __be16 wire format; uint16 decodes in host byte order,
>   which gives wrong values on little-endian architectures.
> - Change OVS_KEY_ATTR_ENCAP type from none to encap_ovskey to
>   enable recursive parsing of 802.1Q encapsulated flow keys.
> - Add push_vlan action class with fields matching kernel struct
>   ovs_action_push_vlan (vlan_tpid, vlan_tci as network-order u16).
> - Add push_vlan dpstr format and parse with range validation
>   (vid 0-4095, pcp 0-7, tpid 0-0xFFFF) and CFI forced to 1.
> - Remove MAX_ENCAP_DEPTH constant and depth tracking -- the
>   bracket-depth counter in the encap parser already handles
>   nesting; the global depth limit was unnecessary.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 322 +++++++++++++++++-
>  1 file changed, 312 insertions(+), 10 deletions(-)

Just some minor nit.  The messages below for parsing are a bit
inconsistent - sometimes they print::

  missing ')' at end

Sometimes::

  missing ')'

And the push_vlan message probably should have 'push_vlan()'

If you want to respin, that would make it friendlier - but this is also
a debug / testing tool, so I'm less concerned with consistency there.
Still I have a thought on the shell script in patch 2/2.

With that:

Reviewed-by: Aaron Conole <aconole@redhat.com>

> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 848f61fdcee0..98d68277b9e7 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -370,7 +370,7 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
>          ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
>          ("OVS_ACTION_ATTR_SET", "ovskey"),
> -        ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
> +        ("OVS_ACTION_ATTR_PUSH_VLAN", "push_vlan"),
>          ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
>          ("OVS_ACTION_ATTR_SAMPLE", "sample"),
>          ("OVS_ACTION_ATTR_RECIRC", "uint32"),
> @@ -427,6 +427,9 @@ class ovsactions(nla):
>  
>              return actstr
>  
> +    class push_vlan(nla):
> +        fields = (("vlan_tpid", "!H"), ("vlan_tci", "!H"))
> +
>      class sample(nla):
>          nla_flags = NLA_F_NESTED
>  
> @@ -633,6 +636,14 @@ class ovsactions(nla):
>                  print_str += "ct_clear"
>              elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
>                  print_str += "pop_vlan"
> +            elif field[0] == "OVS_ACTION_ATTR_PUSH_VLAN":
> +                datum = self.get_attr(field[0])
> +                tpid = datum["vlan_tpid"]
> +                tci = datum["vlan_tci"]
> +                vid = tci & 0x0FFF
> +                pcp = (tci >> 13) & 0x7
> +                print_str += "push_vlan(vid=%d,pcp=%d" \
> +                    ",tpid=0x%04x)" % (vid, pcp, tpid)
>              elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
>                  print_str += "pop_eth"
>              elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
> @@ -726,7 +737,57 @@ class ovsactions(nla):
>                      actstr = actstr[strspn(actstr, ", ") :]
>                      parsed = True
>  
> -            if parse_starts_block(actstr, "clone(", False):
> +            if parse_starts_block(actstr, "push_vlan(", False):
> +                actstr = actstr[len("push_vlan("):]
> +                vid = 0
> +                pcp = 0
> +                tpid = 0x8100
> +                if ")" not in actstr:
> +                    raise ValueError(
> +                        "push_vlan: missing ')'")
> +                paren = actstr.index(")")
> +                if not actstr[:paren].strip():
> +                    raise ValueError("push_vlan: no fields")
> +                for kv in actstr[:paren].split(","):
> +                    if "=" not in kv:
> +                        raise ValueError(
> +                            "push_vlan: bad field '%s'"
> +                            % kv.strip())
> +                    k = kv[:kv.index("=")].strip()
> +                    v = kv[kv.index("=") + 1:].strip()
> +                    if k == "vid":
> +                        vid = int(v, 0)
> +                        if vid < 0 or vid > 0xFFF:
> +                            raise ValueError(
> +                                "push_vlan: vid=%d out of "
> +                                "range (0-4095)" % vid)
> +                    elif k == "pcp":
> +                        pcp = int(v, 0)
> +                        if pcp < 0 or pcp > 7:
> +                            raise ValueError(
> +                                "push_vlan: pcp=%d out of "
> +                                "range (0-7)" % pcp)
> +                    elif k == "tpid":
> +                        tpid = int(v, 0)
> +                        if tpid < 0 or tpid > 0xFFFF:
> +                            raise ValueError(
> +                                "push_vlan: tpid=0x%x out "
> +                                "of range (0-0xffff)" % tpid)
> +                    else:
> +                        raise ValueError(
> +                            "push_vlan: unknown key '%s'"
> +                            % k)
> +                tci = (vid & 0x0FFF) | ((pcp & 0x7) << 13) \
> +                    | 0x1000
> +                pvact = self.push_vlan()
> +                pvact["vlan_tpid"] = tpid
> +                pvact["vlan_tci"] = tci
> +                self["attrs"].append(
> +                    ["OVS_ACTION_ATTR_PUSH_VLAN", pvact])
> +                actstr = actstr[paren + 1:]
> +                parsed = True
> +
> +            elif parse_starts_block(actstr, "clone(", False):
>                  parencount += 1
>                  subacts = ovsactions()
>                  actstr = actstr[len("clone("):]
> @@ -901,11 +962,11 @@ class ovskey(nla):
>      nla_flags = NLA_F_NESTED
>      nla_map = (
>          ("OVS_KEY_ATTR_UNSPEC", "none"),
> -        ("OVS_KEY_ATTR_ENCAP", "none"),
> +        ("OVS_KEY_ATTR_ENCAP", "encap_ovskey"),
>          ("OVS_KEY_ATTR_PRIORITY", "uint32"),
>          ("OVS_KEY_ATTR_IN_PORT", "uint32"),
>          ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
> -        ("OVS_KEY_ATTR_VLAN", "uint16"),
> +        ("OVS_KEY_ATTR_VLAN", "be16"),
>          ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
>          ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
>          ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
> @@ -1636,6 +1697,194 @@ class ovskey(nla):
>      class ovs_key_mpls(nla):
>          fields = (("lse", ">I"),)
>  
> +    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
> +    _VLAN_CFI_MASK = 0x1000
> +
> +    @staticmethod
> +    def _vlan_dpstr(tci):
> +        """Format VLAN TCI as vid=X,pcp=Y,cfi=Z or tci=0xNNNN.
> +
> +        When cfi=1 (standard Ethernet VLAN), outputs decomposed
> +        vid/pcp/cfi fields. When cfi=0 (truncated VLAN header),
> +        falls back to raw tci=0x%04x to ensure round-trip
> +        correctness: the parser auto-adds cfi=1 for vid/pcp
> +        format, so cfi=0 would be lost on re-parse."""
> +        vid = tci & 0x0FFF
> +        pcp = (tci >> 13) & 0x7
> +        cfi = (tci >> 12) & 0x1
> +        if cfi:
> +            return "vid=%d,pcp=%d,cfi=%d" % (vid, pcp, cfi)
> +        return "tci=0x%04x" % tci
> +
> +    @staticmethod
> +    def _parse_vlan_from_flowstr(flowstr):
> +        """Parse vlan(tci=X) or vlan(vid=X[,pcp=Y,cfi=Z]) from flowstr.
> +
> +        Returns (remaining_flowstr, key_tci, mask_tci).
> +        TCI values use standard bit layout (VID bits 0-11,
> +        CFI bit 12, PCP bits 13-15); byte order conversion to
> +        big-endian happens in pyroute2 be16 NLA serialization.
> +        The mask covers only the fields the caller specified:
> +        vid -> 0x0FFF, pcp -> 0xE000, cfi -> 0x1000, tci -> 0xFFFF.
> +
> +        The tci= key sets the raw TCI bitfield (no CFI validation) to allow
> +        non-Ethernet use cases.  Use cfi=1 for standard Ethernet VLAN matching.
> +        """
> +        tci = 0
> +        mask = 0
> +        has_tci = False
> +        has_vid = has_pcp = has_cfi = False
> +        _tci_mix_err = "vlan(): 'tci' cannot be mixed " \
> +                       "with 'vid'/'pcp'/'cfi'"
> +        first = True
> +        while True:
> +            flowstr = flowstr.lstrip()
> +            if not flowstr:
> +                raise ValueError("vlan(): missing ')'")
> +            if flowstr[0] == ')':
> +                break
> +            if not first:
> +                flowstr = flowstr[1:]  # skip ','
> +                if not flowstr:
> +                    raise ValueError("vlan(): missing ')' after trailing comma")
> +                flowstr = flowstr.lstrip()
> +                if flowstr and flowstr[0] == ')':
> +                    break
> +                if flowstr and flowstr[0] == ',':
> +                    raise ValueError(
> +                        "vlan(): empty or extra comma in field list")
> +            first = False
> +
> +            eq = flowstr.find('=')
> +            if eq == -1:
> +                raise ValueError(
> +                    "vlan(): expected key=value, got '%s'" % flowstr)
> +            key = flowstr[:eq].strip()
> +            flowstr = flowstr[eq + 1:]
> +
> +            end = flowstr.find(',')
> +            end2 = flowstr.find(')')
> +            if end == -1 and end2 == -1:
> +                raise ValueError("vlan(): missing ')'")
> +            if end == -1 or (end2 != -1 and end2 < end):
> +                end = end2
> +            val = flowstr[:end].strip()
> +            flowstr = flowstr[end:]
> +
> +            if not val:
> +                raise ValueError("vlan(): empty value for key '%s'" % key)
> +            try:
> +                v = int(val, 16) if val.startswith(('0x', '0X')) else int(val)
> +            except ValueError as exc:
> +                raise ValueError(
> +                    "vlan(): invalid value '%s' for key '%s'"
> +                    % (val, key)) from exc
> +
> +            if key == 'tci':
> +                if has_tci:
> +                    raise ValueError("vlan(): duplicate 'tci'")
> +                if has_vid or has_pcp or has_cfi:
> +                    raise ValueError(_tci_mix_err)
> +                if v > 0xFFFF or v < 0:
> +                    raise ValueError("vlan(): tci=0x%x out of range" % v)
> +                tci = v
> +                mask = 0xFFFF
> +                has_tci = True
> +            elif key == 'vid':
> +                if has_tci:
> +                    raise ValueError(_tci_mix_err)
> +                if has_vid:
> +                    raise ValueError("vlan(): duplicate 'vid'")
> +                if v < 0 or v > 0xFFF:
> +                    raise ValueError("vlan(): vid=%d out of range (0-4095)" % v)
> +                tci |= v
> +                mask |= 0x0FFF
> +                has_vid = True
> +            elif key == 'pcp':
> +                if has_tci:
> +                    raise ValueError(_tci_mix_err)
> +                if has_pcp:
> +                    raise ValueError("vlan(): duplicate 'pcp'")
> +                if v < 0 or v > 7:
> +                    raise ValueError("vlan(): pcp=%d out of range (0-7)" % v)
> +                tci |= (v & 0x7) << 13
> +                mask |= 0xE000
> +                has_pcp = True
> +            elif key == 'cfi':
> +                if has_tci:
> +                    raise ValueError(_tci_mix_err)
> +                if has_cfi:
> +                    raise ValueError("vlan(): duplicate 'cfi'")
> +                if v != 1:
> +                    raise ValueError("vlan(): cfi must be 1 for Ethernet")
> +                tci |= ovskey._VLAN_CFI_MASK
> +                mask |= ovskey._VLAN_CFI_MASK
> +                has_cfi = True
> +            else:
> +                raise ValueError("vlan(): unknown key '%s'" % key)
> +
> +        flowstr = flowstr[1:]  # skip ')'
> +        # Catch immediate '))' (user error).  A ')' after ',' is consumed
> +        # by parse()'s strspn(flowstr, "), ") inter-field separator stripping.
> +        if flowstr.lstrip().startswith(')'):
> +            raise ValueError("vlan(): unmatched ')'")
> +        # parse() strips trailing ',', ')', ' ' as inter-field separators,
> +        # so we do not need to call strspn here.
> +
> +        if mask == 0:
> +            raise ValueError("vlan(): no fields specified, "
> +                             "use vlan(vid=X[,pcp=Y,cfi=Z]) or vlan(tci=X)")
> +        if not has_tci:
> +            tci |= ovskey._VLAN_CFI_MASK
> +            mask |= ovskey._VLAN_CFI_MASK
> +        return flowstr, tci, mask
> +
> +    @staticmethod
> +    def _parse_encap_from_flowstr(flowstr):
> +        """Parse encap(inner_flow) from flowstr.
> +
> +        Returns (remaining_flowstr, inner_key_dict, inner_mask_dict)
> +        where each dict has an 'attrs' key for recursive NLA encoding.
> +        Parenthesis-depth tracking handles nested encap() calls but not
> +        quoted strings containing literal parentheses.
> +        """
> +        depth = 1
> +        end = -1
> +        for i, c in enumerate(flowstr):
> +            if c == '(':
> +                depth += 1
> +            elif c == ')':
> +                depth -= 1
> +                if depth < 0:
> +                    raise ValueError(
> +                        "encap(): unmatched ')' at position %d" % i)
> +                if depth == 0:
> +                    end = i
> +                    break
> +
> +        if end == -1:
> +            if depth > 1:
> +                raise ValueError("encap(): missing ')' at end")
> +            raise ValueError("encap(): missing closing ')'")
> +
> +        inner_str = flowstr[:end].strip()
> +        if not inner_str:
> +            raise ValueError("encap(): empty inner flow")
> +
> +        flowstr = flowstr[end + 1:]
> +        if flowstr.lstrip().startswith(')'):
> +            raise ValueError("encap(): unmatched ')' after encap()")
> +
> +        inner_key = encap_ovskey()
> +        inner_mask = encap_ovskey()
> +        remaining = inner_key.parse(inner_str, inner_mask)
> +        if remaining and re.search(r'[^\s,)]', remaining):
> +            raise ValueError(
> +                "encap(): unrecognized trailing "
> +                "content '%s'" % remaining.strip())
> +
> +        return flowstr, inner_key, inner_mask
> +
>      def parse(self, flowstr, mask=None):
>          for field in (
>              ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
> @@ -1657,6 +1906,16 @@ class ovskey(nla):
>                  "eth_type",
>                  lambda x: intparse(x, "0xffff"),
>              ),
> +            (
> +                "OVS_KEY_ATTR_VLAN",
> +                "vlan",
> +                ovskey._parse_vlan_from_flowstr,
> +            ),
> +            (
> +                "OVS_KEY_ATTR_ENCAP",
> +                "encap",
> +                ovskey._parse_encap_from_flowstr,
> +            ),
>              (
>                  "OVS_KEY_ATTR_IPV4",
>                  "ipv4",
> @@ -1794,6 +2053,9 @@ class ovskey(nla):
>                  True,
>              ),
>              ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
> +            ("OVS_KEY_ATTR_VLAN", "vlan", ovskey._vlan_dpstr,
> +                lambda x: False, True),
> +            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
>              (
>                  "OVS_KEY_ATTR_ETHERTYPE",
>                  "eth_type",
> @@ -1821,22 +2083,61 @@ class ovskey(nla):
>              v = self.get_attr(field[0])
>              if v is not None:
>                  m = None if mask is None else mask.get_attr(field[0])
> +                fmt = field[2]  # str format or callable
>                  if field[4] is False:
>                      print_str += v.dpstr(m, more)
>                      print_str += ","
>                  else:
>                      if m is None or field[3](m):
> -                        print_str += field[1] + "("
> -                        print_str += field[2] % v
> -                        print_str += "),"
> +                        val = fmt(v) if callable(fmt) else fmt % v
> +                        print_str += field[1] + "(" + val + "),"
>                      elif more or m != 0:
> -                        print_str += field[1] + "("
> -                        print_str += (field[2] % v) + "/" + (field[2] % m)
> -                        print_str += "),"
> +                        if callable(fmt):
> +                            val = fmt(v) + "/" + fmt(m)
> +                        else:
> +                            val = (fmt % v) + "/" + (fmt % m)
> +                        print_str += field[1] + "(" + val + "),"
>  
>          return print_str
>  
>  
> +class encap_ovskey(ovskey):
> +    """Inner flow key attributes valid inside 802.1Q ENCAP.
> +
> +    Only L2-L4 key attributes (slots 0-21) appear inside ENCAP.
> +    Metadata-only attributes (SKB_MARK, DP_HASH, RECIRC_ID, etc.)
> +    are set to "none" -- they never appear inside ENCAP per
> +    ovs_nla_put_vlan() in net/openvswitch/flow_netlink.c.
> +
> +    nla_map indexes must match OVS_KEY_ATTR_* enum values in
> +    include/uapi/linux/openvswitch.h.
> +    """
> +    nla_map = (
> +        ("OVS_KEY_ATTR_UNSPEC", "none"),
> +        ("OVS_KEY_ATTR_ENCAP", "none"),  # placeholder, parsed by ovskey
> +        ("OVS_KEY_ATTR_PRIORITY", "none"),  # skb metadata, not in ENCAP
> +        ("OVS_KEY_ATTR_IN_PORT", "none"),  # skb metadata, not in ENCAP
> +        ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
> +        ("OVS_KEY_ATTR_VLAN", "be16"),
> +        ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
> +        ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
> +        ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
> +        ("OVS_KEY_ATTR_TCP", "ovs_key_tcp"),
> +        ("OVS_KEY_ATTR_UDP", "ovs_key_udp"),
> +        ("OVS_KEY_ATTR_ICMP", "ovs_key_icmp"),
> +        ("OVS_KEY_ATTR_ICMPV6", "ovs_key_icmpv6"),
> +        ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),
> +        ("OVS_KEY_ATTR_ND", "ovs_key_nd"),
> +        ("OVS_KEY_ATTR_SKB_MARK", "none"),  # metadata, not in ENCAP
> +        ("OVS_KEY_ATTR_TUNNEL", "none"),  # tunnel metadata, not in ENCAP
> +        ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),
> +        ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),
> +        ("OVS_KEY_ATTR_DP_HASH", "none"),  # metadata, not in ENCAP
> +        ("OVS_KEY_ATTR_RECIRC_ID", "none"),  # metadata, not in ENCAP
> +        ("OVS_KEY_ATTR_MPLS", "array(ovs_key_mpls)"),
> +    )
> +
> +
>  class OvsPacket(GenericNetlinkSocket):
>      OVS_PACKET_CMD_MISS = 1  # Flow table miss
>      OVS_PACKET_CMD_ACTION = 2  # USERSPACE action
> @@ -2576,6 +2877,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
>  
>  
>  def main(argv):
> +    nlmsg_atoms.encap_ovskey = encap_ovskey
>      nlmsg_atoms.ovskey = ovskey
>      nlmsg_atoms.ovsactions = ovsactions


