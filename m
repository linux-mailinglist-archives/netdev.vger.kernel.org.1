Return-Path: <netdev+bounces-284922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEexBFhg+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A824DD642
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1585530358AF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB327057D;
	Wed,  6 May 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP8LWQAv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFC47ECE3
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081621; cv=none; b=W95/c1FNE6BXyol2FT6X+ZnHDYgT9FOuFgZLQMrGW93Kk/KRl9sv1TaC2aNKziToj/alzgIGxg9q27U5cM8c/UxF/OkSyCJ08JdJBxdOClLSwLbwiT3Kz7NO14csUU/DYUTL8BX3icIcGZyyN0norsRwMeVaF7N+gUAzI75tvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081621; c=relaxed/simple;
	bh=pyNDS3jdxlPjg/LluVlwBRkMuDlZlQyMS2dclE80z/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tCoXolLIVpkCNzL4NO00NvttC/Qah0+TDD7JiK2yhZTasYgmIk4YyXVOqIxVuSMeMAja6LdouWIZ65/Crjxj+X8Fo/sc90wudOJt1y8Qtp9L68N85aqa1hwR4X2L0EWFbZdvPuwgJfXB6OSngU/pfveH7MJHFcwQgocdZKP12V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JP8LWQAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778081613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4ZOVmYD1FPTDBGebUfEyEpfR4ZPvhHexDxJfyxeI2A=;
	b=JP8LWQAvIpcVR0A8LiIqE5P7Lz1EdA9k2YnwHk1lNIIWJIYLoy6/PpOw5fIl14hDHJXwot
	swndyc5sHZekP9iMpGsq814ucDXtWcQTvWNE28Cm7BKpU2l9F5y3DyDS2waD1DKZe8qIM0
	leHvNO+0RG7/J3IAer9bFr9cIWLLPkE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160--cSiifjJOoKUc15Xy64T9Q-1; Wed,
 06 May 2026 11:33:30 -0400
X-MC-Unique: -cSiifjJOoKUc15Xy64T9Q-1
X-Mimecast-MFC-AGG-ID: -cSiifjJOoKUc15Xy64T9Q_1778081608
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51EF918002EA;
	Wed,  6 May 2026 15:33:28 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1AEE18004A3;
	Wed,  6 May 2026 15:33:24 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] selftests: openvswitch: add vlan() and
 encap() flow string parsing
In-Reply-To: <20260505124957.1239812-2-houminxi@gmail.com> (Minxi Hou's
	message of "Tue, 5 May 2026 20:49:56 +0800")
References: <20260505124957.1239812-1-houminxi@gmail.com>
	<20260505124957.1239812-2-houminxi@gmail.com>
Date: Wed, 06 May 2026 11:33:23 -0400
Message-ID: <f7to6istuws.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 71A824DD642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovs-dpctl.py:url]

Minxi Hou <houminxi@gmail.com> writes:

> Add VLAN TCI formatting and parsing support to ovs-dpctl.py:
>
> - Add _vlan_dpstr() to decompose TCI into vid/pcp/cfi fields,
>   with raw tci=3D0x%04x fallback when cfi=3D0 for round-trip safety.
> - Add _parse_vlan_from_flowstr() boundary check for missing ')'.
> - Add encap_ovskey subclass restricting nla_map to L2-L4 attributes
>   (slots 0-21) that appear inside 802.1Q ENCAP, with metadata
>   attributes set to "none".
> - Check parse() return value for unrecognized trailing content.
> - Support callable format functions in dpstr() output.
> - Add push_vlan action class with fields matching kernel struct
>   ovs_action_push_vlan (vlan_tpid, vlan_tci as network-order u16).
> - Add push_vlan dpstr format and parse with range validation
>   (vid 0-4095, pcp 0-7, tpid 0-0xFFFF) and CFI forced to 1.
> - Remove MAX_ENCAP_DEPTH constant and depth tracking =E2=80=94 the
>   bracket-depth counter in the encap parser already handles
>   nesting; the global depth limit was unnecessary.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

It's worth noting that there are pylint errors introduced with this
patch.  HOWEVER, they are related to things like pascal case (where
ovs-dpctl.py prefers snake_case), and using explicit string formatting
vs f-string.  I think it is okay to ignore these errors since it keeps
the file consistent, and it may be worth cleaning some of those up
(missing docstring and f-string conversion) at another time.

>  .../selftests/net/openvswitch/ovs-dpctl.py    | 322 +++++++++++++++++-
>  1 file changed, 312 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools=
/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 848f61fdcee0..50551d4fa7c7 100644
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
>=20=20
>              return actstr
>=20=20
> +    class push_vlan(nla):
> +        fields =3D (("vlan_tpid", "!H"), ("vlan_tci", "!H"))
> +
>      class sample(nla):
>          nla_flags =3D NLA_F_NESTED
>=20=20
> @@ -633,6 +636,14 @@ class ovsactions(nla):
>                  print_str +=3D "ct_clear"
>              elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_VLAN":
>                  print_str +=3D "pop_vlan"
> +            elif field[0] =3D=3D "OVS_ACTION_ATTR_PUSH_VLAN":
> +                datum =3D self.get_attr(field[0])
> +                tpid =3D datum["vlan_tpid"]
> +                tci =3D datum["vlan_tci"]
> +                vid =3D tci & 0x0FFF
> +                pcp =3D (tci >> 13) & 0x7
> +                print_str +=3D "push_vlan(vid=3D%d,pcp=3D%d" \
> +                    ",tpid=3D0x%04x)" % (vid, pcp, tpid)
>              elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_ETH":
>                  print_str +=3D "pop_eth"
>              elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_NSH":
> @@ -726,7 +737,57 @@ class ovsactions(nla):
>                      actstr =3D actstr[strspn(actstr, ", ") :]
>                      parsed =3D True
>=20=20
> -            if parse_starts_block(actstr, "clone(", False):
> +            if parse_starts_block(actstr, "push_vlan(", False):
> +                actstr =3D actstr[len("push_vlan("):]
> +                vid =3D 0
> +                pcp =3D 0
> +                tpid =3D 0x8100
> +                if ")" not in actstr:
> +                    raise ValueError(
> +                        "push_vlan: missing ')'")
> +                paren =3D actstr.index(")")
> +                if not actstr[:paren].strip():
> +                    raise ValueError("push_vlan: no fields")
> +                for kv in actstr[:paren].split(","):
> +                    if "=3D" not in kv:
> +                        raise ValueError(
> +                            "push_vlan: bad field '%s'"
> +                            % kv.strip())
> +                    k =3D kv[:kv.index("=3D")].strip()
> +                    v =3D kv[kv.index("=3D") + 1:].strip()
> +                    if k =3D=3D "vid":
> +                        vid =3D int(v, 0)
> +                        if vid < 0 or vid > 0xFFF:
> +                            raise ValueError(
> +                                "push_vlan: vid=3D%d out of "
> +                                "range (0-4095)" % vid)
> +                    elif k =3D=3D "pcp":
> +                        pcp =3D int(v, 0)
> +                        if pcp < 0 or pcp > 7:
> +                            raise ValueError(
> +                                "push_vlan: pcp=3D%d out of "
> +                                "range (0-7)" % pcp)
> +                    elif k =3D=3D "tpid":
> +                        tpid =3D int(v, 0)
> +                        if tpid < 0 or tpid > 0xFFFF:
> +                            raise ValueError(
> +                                "push_vlan: tpid=3D0x%x out "
> +                                "of range (0-0xffff)" % tpid)
> +                    else:
> +                        raise ValueError(
> +                            "push_vlan: unknown key '%s'"
> +                            % k)
> +                tci =3D (vid & 0x0FFF) | ((pcp & 0x7) << 13) \
> +                    | 0x1000
> +                pvact =3D self.push_vlan()
> +                pvact["vlan_tpid"] =3D tpid
> +                pvact["vlan_tci"] =3D tci
> +                self["attrs"].append(
> +                    ["OVS_ACTION_ATTR_PUSH_VLAN", pvact])
> +                actstr =3D actstr[paren + 1:]
> +                parsed =3D True
> +
> +            elif parse_starts_block(actstr, "clone(", False):
>                  parencount +=3D 1
>                  subacts =3D ovsactions()
>                  actstr =3D actstr[len("clone("):]
> @@ -901,11 +962,11 @@ class ovskey(nla):
>      nla_flags =3D NLA_F_NESTED
>      nla_map =3D (
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
>          fields =3D (("lse", ">I"),)
>=20=20
> +    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethern=
et
> +    _VLAN_CFI_MASK =3D 0x1000
> +
> +    @staticmethod
> +    def _vlan_dpstr(tci):
> +        """Format VLAN TCI as vid=3DX,pcp=3DY,cfi=3DZ or tci=3D0xNNNN.
> +
> +        When cfi=3D1 (standard Ethernet VLAN), outputs decomposed
> +        vid/pcp/cfi fields. When cfi=3D0 (truncated VLAN header),
> +        falls back to raw tci=3D0x%04x to ensure round-trip
> +        correctness: the parser auto-adds cfi=3D1 for vid/pcp
> +        format, so cfi=3D0 would be lost on re-parse."""
> +        vid =3D tci & 0x0FFF
> +        pcp =3D (tci >> 13) & 0x7
> +        cfi =3D (tci >> 12) & 0x1
> +        if cfi:
> +            return "vid=3D%d,pcp=3D%d,cfi=3D%d" % (vid, pcp, cfi)
> +        return "tci=3D0x%04x" % tci
> +
> +    @staticmethod
> +    def _parse_vlan_from_flowstr(flowstr):
> +        """Parse vlan(tci=3DX) or vlan(vid=3DX[,pcp=3DY,cfi=3DZ]) from f=
lowstr.
> +
> +        Returns (remaining_flowstr, key_tci, mask_tci).
> +        TCI values use standard bit layout (VID bits 0-11,
> +        CFI bit 12, PCP bits 13-15); byte order conversion to
> +        big-endian happens in pyroute2 be16 NLA serialization.
> +        The mask covers only the fields the caller specified:
> +        vid -> 0x0FFF, pcp -> 0xE000, cfi -> 0x1000, tci -> 0xFFFF.
> +
> +        The tci=3D key sets the raw TCI bitfield (no CFI validation) to =
allow
> +        non-Ethernet use cases.  Use cfi=3D1 for standard Ethernet VLAN =
matching.
> +        """
> +        tci =3D 0
> +        mask =3D 0
> +        has_tci =3D False
> +        has_vid =3D has_pcp =3D has_cfi =3D False
> +        _tci_mix_err =3D "vlan(): 'tci' cannot be mixed " \
> +                       "with 'vid'/'pcp'/'cfi'"
> +        first =3D True
> +        while True:
> +            flowstr =3D flowstr.lstrip()
> +            if not flowstr:
> +                raise ValueError("vlan(): missing ')'")
> +            if flowstr[0] =3D=3D ')':
> +                break
> +            if not first:
> +                flowstr =3D flowstr[1:]  # skip ','
> +                if not flowstr:
> +                    raise ValueError("vlan(): missing ')' after trailing=
 comma")
> +                flowstr =3D flowstr.lstrip()
> +                if flowstr and flowstr[0] =3D=3D ')':
> +                    break
> +                if flowstr and flowstr[0] =3D=3D ',':
> +                    raise ValueError(
> +                        "vlan(): empty or extra comma in field list")
> +            first =3D False
> +
> +            eq =3D flowstr.find('=3D')
> +            if eq =3D=3D -1:
> +                raise ValueError(
> +                    "vlan(): expected key=3Dvalue, got '%s'" % flowstr)
> +            key =3D flowstr[:eq].strip()
> +            flowstr =3D flowstr[eq + 1:]
> +
> +            end =3D flowstr.find(',')
> +            end2 =3D flowstr.find(')')
> +            if end =3D=3D -1 and end2 =3D=3D -1:
> +                raise ValueError("vlan(): missing ')'")
> +            if end =3D=3D -1 or (end2 !=3D -1 and end2 < end):
> +                end =3D end2
> +            val =3D flowstr[:end].strip()
> +            flowstr =3D flowstr[end:]
> +
> +            if not val:
> +                raise ValueError("vlan(): empty value for key '%s'" % ke=
y)
> +            try:
> +                v =3D int(val, 16) if val.startswith(('0x', '0X')) else =
int(val)
> +            except ValueError as exc:
> +                raise ValueError(
> +                    "vlan(): invalid value '%s' for key '%s'"
> +                    % (val, key)) from exc
> +
> +            if key =3D=3D 'tci':
> +                if has_tci:
> +                    raise ValueError("vlan(): duplicate 'tci'")
> +                if has_vid or has_pcp or has_cfi:
> +                    raise ValueError(_tci_mix_err)
> +                if v > 0xFFFF or v < 0:
> +                    raise ValueError("vlan(): tci=3D0x%x out of range" %=
 v)
> +                tci =3D v
> +                mask =3D 0xFFFF
> +                has_tci =3D True
> +            elif key =3D=3D 'vid':
> +                if has_tci:
> +                    raise ValueError(_tci_mix_err)
> +                if has_vid:
> +                    raise ValueError("vlan(): duplicate 'vid'")
> +                if v < 0 or v > 0xFFF:
> +                    raise ValueError("vlan(): vid=3D%d out of range (0-4=
095)" % v)
> +                tci |=3D v
> +                mask |=3D 0x0FFF
> +                has_vid =3D True
> +            elif key =3D=3D 'pcp':
> +                if has_tci:
> +                    raise ValueError(_tci_mix_err)
> +                if has_pcp:
> +                    raise ValueError("vlan(): duplicate 'pcp'")
> +                if v < 0 or v > 7:
> +                    raise ValueError("vlan(): pcp=3D%d out of range (0-7=
)" % v)
> +                tci |=3D (v & 0x7) << 13
> +                mask |=3D 0xE000
> +                has_pcp =3D True
> +            elif key =3D=3D 'cfi':
> +                if has_tci:
> +                    raise ValueError(_tci_mix_err)
> +                if has_cfi:
> +                    raise ValueError("vlan(): duplicate 'cfi'")
> +                if v !=3D 1:
> +                    raise ValueError("vlan(): cfi must be 1 for Ethernet=
")
> +                tci |=3D ovskey._VLAN_CFI_MASK
> +                mask |=3D ovskey._VLAN_CFI_MASK
> +                has_cfi =3D True
> +            else:
> +                raise ValueError("vlan(): unknown key '%s'" % key)
> +
> +        flowstr =3D flowstr[1:]  # skip ')'
> +        # Catch immediate '))' (user error).  A ')' after ',' is consumed
> +        # by parse()'s strspn(flowstr, "), ") inter-field separator stri=
pping.
> +        if flowstr.lstrip().startswith(')'):
> +            raise ValueError("vlan(): unmatched ')'")
> +        # parse() strips trailing ',', ')', ' ' as inter-field separator=
s,
> +        # so we do not need to call strspn here.
> +
> +        if mask =3D=3D 0:
> +            raise ValueError("vlan(): no fields specified, "
> +                             "use vlan(vid=3DX[,pcp=3DY,cfi=3DZ]) or vla=
n(tci=3DX)")
> +        if not has_tci:
> +            tci |=3D ovskey._VLAN_CFI_MASK
> +            mask |=3D ovskey._VLAN_CFI_MASK
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
> +        depth =3D 1
> +        end =3D -1
> +        for i, c in enumerate(flowstr):
> +            if c =3D=3D '(':
> +                depth +=3D 1
> +            elif c =3D=3D ')':
> +                depth -=3D 1
> +                if depth < 0:
> +                    raise ValueError(
> +                        "encap(): unmatched ')' at position %d" % i)
> +                if depth =3D=3D 0:
> +                    end =3D i
> +                    break
> +
> +        if end =3D=3D -1:
> +            if depth > 1:
> +                raise ValueError("encap(): missing ')' at end")
> +            raise ValueError("encap(): missing closing ')'")
> +
> +        inner_str =3D flowstr[:end].strip()
> +        if not inner_str:
> +            raise ValueError("encap(): empty inner flow")
> +
> +        flowstr =3D flowstr[end + 1:]
> +        if flowstr.lstrip().startswith(')'):
> +            raise ValueError("encap(): unmatched ')' after encap()")
> +
> +        inner_key =3D encap_ovskey()
> +        inner_mask =3D encap_ovskey()
> +        remaining =3D inner_key.parse(inner_str, inner_mask)
> +        if remaining and re.search(r'[^\s,)]', remaining):
> +            raise ValueError(
> +                "encap(): unrecognized trailing "
> +                "content '%s'" % remaining.strip())
> +
> +        return flowstr, inner_key, inner_mask
> +
>      def parse(self, flowstr, mask=3DNone):
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
>              v =3D self.get_attr(field[0])
>              if v is not None:
>                  m =3D None if mask is None else mask.get_attr(field[0])
> +                fmt =3D field[2]  # str format or callable
>                  if field[4] is False:
>                      print_str +=3D v.dpstr(m, more)
>                      print_str +=3D ","
>                  else:
>                      if m is None or field[3](m):
> -                        print_str +=3D field[1] + "("
> -                        print_str +=3D field[2] % v
> -                        print_str +=3D "),"
> +                        val =3D fmt(v) if callable(fmt) else fmt % v
> +                        print_str +=3D field[1] + "(" + val + "),"
>                      elif more or m !=3D 0:
> -                        print_str +=3D field[1] + "("
> -                        print_str +=3D (field[2] % v) + "/" + (field[2] =
% m)
> -                        print_str +=3D "),"
> +                        if callable(fmt):
> +                            val =3D fmt(v) + "/" + fmt(m)
> +                        else:
> +                            val =3D (fmt % v) + "/" + (fmt % m)
> +                        print_str +=3D field[1] + "(" + val + "),"
>=20=20
>          return print_str
>=20=20
>=20=20
> +class encap_ovskey(ovskey):
> +    """Inner flow key attributes valid inside 802.1Q ENCAP.
> +
> +    Only L2-L4 key attributes (slots 0-21) appear inside ENCAP.
> +    Metadata-only attributes (SKB_MARK, DP_HASH, RECIRC_ID, etc.)
> +    are set to "none" =E2=80=94 they never appear inside ENCAP per
> +    ovs_nla_put_vlan() in net/openvswitch/flow_netlink.c.
> +
> +    nla_map indexes must match OVS_KEY_ATTR_* enum values in
> +    include/uapi/linux/openvswitch.h.
> +    """
> +    nla_map =3D (

I was thinking that we might be able to use something like:

  nla_map =3D ovskey.nlamap

But the comment clearly describes why we have this separate structure.
That said:

> +        ("OVS_KEY_ATTR_UNSPEC", "none"),       # 0
> +        ("OVS_KEY_ATTR_ENCAP", "none"),        # 1 =E2=80=94 placeholder=
, no recursion
> +        ("OVS_KEY_ATTR_PRIORITY", "none"),       # 2 =E2=80=94 skb metad=
ata, not in ENCAP
> +        ("OVS_KEY_ATTR_IN_PORT", "none"),       # 3 =E2=80=94 skb metada=
ta, not in ENCAP

I don't think the '# <num>' are useful.  It may be useful to just
indicate the ones that are different from the ovskey base type, but not
include the number (looks like excess noise).

Otherwise, looks good to me.

> +        ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),   # 4
> +        ("OVS_KEY_ATTR_VLAN", "be16"),          # 5
> +        ("OVS_KEY_ATTR_ETHERTYPE", "be16"),     # 6
> +        ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),  # 7
> +        ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),  # 8
> +        ("OVS_KEY_ATTR_TCP", "ovs_key_tcp"),    # 9
> +        ("OVS_KEY_ATTR_UDP", "ovs_key_udp"),    # 10
> +        ("OVS_KEY_ATTR_ICMP", "ovs_key_icmp"),  # 11
> +        ("OVS_KEY_ATTR_ICMPV6", "ovs_key_icmpv6"),  # 12
> +        ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),    # 13
> +        ("OVS_KEY_ATTR_ND", "ovs_key_nd"),      # 14
> +        ("OVS_KEY_ATTR_SKB_MARK", "none"),      # 15 =E2=80=94 metadata,=
 not in ENCAP
> +        ("OVS_KEY_ATTR_TUNNEL", "none"),        # 16 =E2=80=94 tunnel me=
tadata, not in ENCAP
> +        ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),  # 17
> +        ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),     # 18
> +        ("OVS_KEY_ATTR_DP_HASH", "none"),       # 19 =E2=80=94 metadata,=
 not in ENCAP
> +        ("OVS_KEY_ATTR_RECIRC_ID", "none"),     # 20 =E2=80=94 metadata,=
 not in ENCAP
> +        ("OVS_KEY_ATTR_MPLS", "array(ovs_key_mpls)"),  # 21
> +    )
> +
> +
>  class OvsPacket(GenericNetlinkSocket):
>      OVS_PACKET_CMD_MISS =3D 1  # Flow table miss
>      OVS_PACKET_CMD_ACTION =3D 2  # USERSPACE action
> @@ -2576,6 +2877,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=3D=
NDB(), vpl=3DOvsVport()):
>=20=20
>=20=20
>  def main(argv):
> +    nlmsg_atoms.encap_ovskey =3D encap_ovskey
>      nlmsg_atoms.ovskey =3D ovskey
>      nlmsg_atoms.ovsactions =3D ovsactions


