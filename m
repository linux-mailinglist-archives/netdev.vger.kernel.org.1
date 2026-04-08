Return-Path: <netdev+bounces-276351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ84IbIP1mmxAwgAu9opvQ
	(envelope-from <netdev+bounces-276351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:20:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 790123B8E6D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69562300406A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021E39EF0E;
	Wed,  8 Apr 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CFVBICno"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526539EF17
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636395; cv=none; b=fXy5KrDZaHWx5lh2fQM1rSO+paH40EY8vsZQEVZcOupDpszBgXbuOWbRIHsqId+/HPVBNBERcZCucdaY52OMwg/tQQgpDHAJ9cAjL5Oz+/QI8iKLb5V1jI53j7ykL649g8z39BGkNviWxIVAsnUbioLa5sk9tAotg9m/7o2nc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636395; c=relaxed/simple;
	bh=VciSlF9Vn8KxDyJWHxlxH/gqILvcbkQDhWC25YDBMVk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Vo00u0Zgzg+0+bP+uSUjcea0OgKnfK7JbXYpkB6Q4UPD1OmitbZN2Dw4E+9yera37YbwYeRPSabq1DbOwZQmfPZdvcW7DhTCtTyROm2gMieFn5AA3LoVpMt9otXwsem4TslyjCFH7GKYHR2d9GWUL9GswdQSeAubQscCXAZbNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CFVBICno; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 08 Apr 2026 10:19:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775636391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VciSlF9Vn8KxDyJWHxlxH/gqILvcbkQDhWC25YDBMVk=;
	b=CFVBICnooh0oV7Xm90XaDuhGC+X39xzaj79iv2PldwUXLBuHPca4hNefHbhfSPBwMz+nZ/
	9HK+eEiX5tmK8cGLH+LvKe9rpN+kz20RMR8Au6DuHxoGuksRfvkhIL+OdBhQYox2u2x9wN
	KnMbqAAUKRXMoHeWuaMMtRQb1zPNk9Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
CC: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v5_1/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_require_valid_EOT_supervision_TLV?=
In-Reply-To: <15888967-8372-4c6b-b3ec-3cb336dcebbb@suse.de>
References: <20260407162502.19462-1-luka.gejak@linux.dev> <20260407162502.19462-2-luka.gejak@linux.dev> <e29b7837-70ab-4db2-b9e5-abb59d8721d7@suse.de> <15888967-8372-4c6b-b3ec-3cb336dcebbb@suse.de>
Message-ID: <D76B5C30-622A-4A58-AEAF-D26565FA0B61@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-276351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 790123B8E6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 8, 2026 10:05:31 AM GMT+02:00, Fernando Fernandez Mancera <fmancer=
a@suse=2Ede> wrote:
>On 4/8/26 9:48 AM, Fernando Fernandez Mancera wrote:
>> On 4/7/26 6:25 PM, luka=2Egejak@linux=2Edev wrote:
>>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>>=20
>>> Supervision frames are only valid if terminated with a zero-length EOT
>>> TLV=2E The current check fails to reject non-EOT entries as the termin=
al
>>> TLV, potentially allowing malformed supervision traffic=2E
>>>=20
>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>> with a length of zero, and properly linearizing the TLV header before
>>> access=2E
>>>=20
>>> Assisted-by: Gemini:Gemini-3=2E1-flash
>>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>>> ---
>>> =C2=A0 net/hsr/hsr_forward=2Ec | 20 +++++++++-----------
>>> =C2=A0 1 file changed, 9 insertions(+), 11 deletions(-)
>>>=20
>>> diff --git a/net/hsr/hsr_forward=2Ec b/net/hsr/hsr_forward=2Ec
>>> index 0aca859c88cb=2E=2Eeb89cc44eac0 100644
>>> --- a/net/hsr/hsr_forward=2Ec
>>> +++ b/net/hsr/hsr_forward=2Ec
>>> @@ -82,35 +82,33 @@ static bool is_supervision_frame(struct hsr_priv *=
hsr, struct sk_buff *skb)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsr_sup_tag->tl=
v=2EHSR_TLV_length !=3D sizeof(struct hsr_sup_payload))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> -=C2=A0=C2=A0=C2=A0 /* Get next tlv */
>>> +=C2=A0=C2=A0=C2=A0 /* Get next TLV */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_length +=3D hsr_sup_tag->tlv=2EHS=
R_TLV_length;
>>> -=C2=A0=C2=A0=C2=A0 if (!pskb_may_pull(skb, total_length))
>>> +=C2=A0=C2=A0=C2=A0 if (!pskb_may_pull(skb, total_length + sizeof(stru=
ct hsr_sup_tlv)))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_pull(skb, total_length);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsr_sup_tlv =3D (struct hsr_sup_tlv *)s=
kb->data;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_push(skb, total_length);
>>> -=C2=A0=C2=A0=C2=A0 /* if this is a redbox supervision frame we need t=
o verify
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * that more data is available
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 /* If this is a RedBox supervision frame, verify a=
dditional data */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hsr_sup_tlv->HSR_TLV_type =3D=3D PR=
P_TLV_REDBOX_MAC) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* tlv length must be a le=
ngth of a mac address */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* TLV length must be the =
size of a MAC address */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hsr_sup_tlv=
->HSR_TLV_length !=3D sizeof(struct hsr_sup_payload))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* make sure another tlv f=
ollows */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Make sure another TLV f=
ollows */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_length +=
=3D sizeof(struct hsr_sup_tlv) + hsr_sup_tlv- >HSR_TLV_length;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pskb_may_pull(skb, to=
tal_length))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pskb_may_pull(skb, to=
tal_length + sizeof(struct hsr_sup_tlv)))
>>=20
>> Hi Luka,
>>=20
>> why is the length adjusted here? The current total length was adjusted =
correctly above see:
>>=20
>
>Never mind, it makes sense as the total_length must point to the beginnin=
g of the next TLV=2E
>
>LGTM,
>
>Reviewed-by: Fernando Fernandez Mancera <fmancera@suse=2Ede>
>
>Thanks,
>Fernando=2E
>
Hi Fernando,
Thank you for the follow-up and the reviewed-by tag=2E
I was actually just about to send an explanation regarding the=20
pskb_may_pull() logic, but that seems unnecessary now=2E I'm glad it=20
makes sense on your end as well=2E
Best regards,
Luka
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* get next tlv */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Get next TLV */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_pull(skb, t=
otal_length);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsr_sup_tlv =3D=
 (struct hsr_sup_tlv *)skb->data;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_push(skb, t=
otal_length);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 /* end of tlvs must follow at the end */
>>> -=C2=A0=C2=A0=C2=A0 if (hsr_sup_tlv->HSR_TLV_type =3D=3D HSR_TLV_EOT &=
&
>>> +=C2=A0=C2=A0=C2=A0 /* Supervision frame must end with EOT TLV */
>>> +=C2=A0=C2=A0=C2=A0 if (hsr_sup_tlv->HSR_TLV_type !=3D HSR_TLV_EOT ||
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsr_sup_tlv->HS=
R_TLV_length !=3D 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>=20
>


