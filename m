Return-Path: <netdev+bounces-283925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK++Iue++Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DFF4C0D7E
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F5930048D1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40F3E0C4F;
	Mon,  4 May 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWMtzmLK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472C3E0220
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909411; cv=none; b=PbVcw0yVvvqUNIwxBom3r5fHrRZcAIFFxtF3ynyv4htOd+osT/yzgXM03AMByRs/6MyXdNWcaBcWoCIKSzGSezA7AezkMPlRyfHuY5mCL63h/3BmM/t8AhIWGoddANzBs/p0YnuCGlYyNaVMDhBQQ3DsJhbXLS+bjyOo5rfyQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909411; c=relaxed/simple;
	bh=vAsWLSjvPcN/KLEzRRtxrKOzxHThh9GCVRyAvuOZfsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RHpjOQnJk5lPimwsRBHs8q93z6wPBfuCSNBwgNTyRrq4sphcaT3X0jikup8rdLGM718C62lDYzVruI/ZrOG+eGa7yWuwzEZTXTBQt0P4kQHLMKZV6hQu5Cbwz41l/LKFFjMPUeOM7/0/S9BNDom5A+lCr9v7ZazQf4jfiDZMV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWMtzmLK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=inEAT2MDcwuOXSoFUvn+VW6xKJBd059gSefEAn2Aw8w=;
	b=HWMtzmLKfYGRy6GpgLQ9YmjEUKN3N9jNk0v6nGqkRXD8fWDSBZVTlqGUnG7Q0VsKSCirAr
	dGP+rxIiYMBLa9bk+1bF7piQg4ZYAp6YPTJOqtjrP72Se8qHWsppRkEbQ0VConou11851T
	S5T9F5UD8/zh+eF9kI5JvL39Bf7txFE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-0waVbybDPOe_qZsIlUcpCg-1; Mon,
 04 May 2026 11:43:25 -0400
X-MC-Unique: 0waVbybDPOe_qZsIlUcpCg-1
X-Mimecast-MFC-AGG-ID: 0waVbybDPOe_qZsIlUcpCg_1777909403
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 694941956050;
	Mon,  4 May 2026 15:43:23 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.157])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E2C81944CED;
	Mon,  4 May 2026 15:43:20 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  dev@openvswitch.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah
 Khan <shuah@kernel.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] selftests: openvswitch: add vlan() and
 encap() flow string parsing
In-Reply-To: <20260501133924.3100680-2-houminxi@gmail.com> (Minxi Hou's
	message of "Fri, 1 May 2026 21:39:22 +0800")
References: <20260501133924.3100680-1-houminxi@gmail.com>
	<20260501133924.3100680-2-houminxi@gmail.com>
Date: Mon, 04 May 2026 11:43:18 -0400
Message-ID: <f7tpl3bxjs9.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: D6DFF4C0D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283925-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Minxi Hou <houminxi@gmail.com> writes:

> Extend the ovs-dpctl.py flow parser to support vlan() and encap()
> match strings.  vlan() accepts tci=, vid=, pcp=, and cfi=
> parameters and generates the OVS_KEY_ATTR_VLAN attribute with a TCI
> value in network byte order.  encap() parses nested flow strings
> and returns OVS_KEY_ATTR_ENCAP with inner key attributes as a
> recursive NLA container.
>
> The encap nla_map type is changed from "none" to "nested" so that
> pyroute2 recursively encodes the inner flow key attributes.  The
> VLAN nla_map type is changed from "uint16" to "be16" to match the
> kernel's big-endian wire format.

^ That's kindof a fix, BUT it also seems like we never actually used it
anywhere, so I hope it is okay to not treat it that way.

> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
> v1 -> v2: rebase to latest net-next/main, drop --base=auto
>
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 190 +++++++++++++++++-
>  1 file changed, 188 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 848f61fdcee0..317be7878937 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -901,11 +901,11 @@ class ovskey(nla):
>      nla_flags = NLA_F_NESTED
>      nla_map = (
>          ("OVS_KEY_ATTR_UNSPEC", "none"),
> -        ("OVS_KEY_ATTR_ENCAP", "none"),
> +        ("OVS_KEY_ATTR_ENCAP", "nested"),
>          ("OVS_KEY_ATTR_PRIORITY", "uint32"),
>          ("OVS_KEY_ATTR_IN_PORT", "uint32"),
>          ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
> -        ("OVS_KEY_ATTR_VLAN", "uint16"),
> +        ("OVS_KEY_ATTR_VLAN", "be16"),
>          ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
>          ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
>          ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
> @@ -1636,6 +1636,180 @@ class ovskey(nla):
>      class ovs_key_mpls(nla):
>          fields = (("lse", ">I"),)
>  
> +    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
> +    _VLAN_CFI_MASK = 0x1000
> +    _MAX_ENCAP_DEPTH = 4

It would be more useful if we could set the MAX_ENCAP_DEPTH separately,
so that we have the option to break assumptions.  Maybe just skip a
depth check here completely.

> +    _encap_depth = 0  # single-threaded usage assumed
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
> +                raise ValueError("vlan(): expected key=value, got '%s'" % flowstr)
> +            key = flowstr[:eq].strip()
> +            flowstr = flowstr[eq + 1:]
> +
> +            end = flowstr.find(',')
> +            end2 = flowstr.find(')')
> +            if end == -1 or (end2 != -1 and end2 < end):
> +                end = end2
> +            val = flowstr[:end].strip()
> +            flowstr = flowstr[end:]
> +
> +            if not val:
> +                raise ValueError("vlan(): empty value for key '%s'" % key)
> +            try:
> +                v = int(val, 16) if val.startswith(('0x', '0X')) else int(val)
> +            except ValueError:
> +                raise ValueError("vlan(): invalid value '%s' for key '%s'" %
> +                                 (val, key))
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
> +        if ovskey._encap_depth >= ovskey._MAX_ENCAP_DEPTH:
> +            raise ValueError("encap(): max nesting depth %d exceeded" %
> +                             ovskey._MAX_ENCAP_DEPTH)
> +        try:
> +            ovskey._encap_depth += 1
> +            depth = 1
> +            end = -1
> +            for i, c in enumerate(flowstr):
> +                if c == '(':
> +                    depth += 1
> +                elif c == ')':
> +                    depth -= 1
> +                    if depth < 0:
> +                        raise ValueError("encap(): unmatched ')' at position %d" % i)
> +                    if depth == 0:
> +                        end = i
> +                        break
> +
> +            if end == -1:
> +                if depth > 1:
> +                    raise ValueError("encap(): missing ')' at end")
> +                raise ValueError("encap(): missing closing ')'")
> +
> +            inner_str = flowstr[:end].strip()
> +            if not inner_str:
> +                raise ValueError("encap(): empty inner flow")
> +
> +            flowstr = flowstr[end + 1:]
> +            if flowstr.lstrip().startswith(')'):
> +                raise ValueError("encap(): unmatched ')' after encap()")
> +            # parse() strips trailing ',', ')', ' ' as inter-field separators,
> +            # so we do not need to call strspn here.
> +
> +            inner_key = ovskey()
> +            inner_mask = ovskey()
> +            inner_key.parse(inner_str, inner_mask)
> +
> +            return flowstr, inner_key, inner_mask
> +        finally:
> +            ovskey._encap_depth -= 1
> +
>      def parse(self, flowstr, mask=None):
>          for field in (
>              ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
> @@ -1657,6 +1831,16 @@ class ovskey(nla):
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
> @@ -1794,6 +1978,8 @@ class ovskey(nla):
>                  True,
>              ),
>              ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
> +            ("OVS_KEY_ATTR_VLAN", "vlan", "0x%04x", lambda x: False, True),
> +            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
>              (
>                  "OVS_KEY_ATTR_ETHERTYPE",
>                  "eth_type",


