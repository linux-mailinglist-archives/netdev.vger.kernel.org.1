Return-Path: <netdev+bounces-282436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL1EF8cx8mkjowEAu9opvQ
	(envelope-from <netdev+bounces-282436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:28:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E74497BAD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A65D310880B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7A6410D07;
	Wed, 29 Apr 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzRi40++";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GkK2GDLC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E43FFAD3
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479754; cv=pass; b=sFrLLlpn1Ac5aVk61lrU51yK99jKD9qbRsayT7WYk5ohAClNsJUOIesLEwq/Dk0Jr2IEqMzfac2TfzulJwNUIeNT+HUzNv4y8nJQ/wI+GvClv62shLSnr5Bu0AxAIFM239UbsGD/ylroFnKB/vgHwybijlIg6AajW+p95WtkLBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479754; c=relaxed/simple;
	bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ8y9UviCGyFnwBEgrrP8V9Xp4rrBPu5rbfUdKSzv0zX4wpqfqsP0FMg32Clv8AyvltQDVOfcmcgFfSN+qo4R+CTt9HnSJLLx7JB5V5LiTrjfcEKLDFrqHjWtznjoOnmdGrqMtYDgIyBEiypyWX80GVEjK3fUV/6BmuEQDxFh2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzRi40++; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GkK2GDLC; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF7UPo1641654
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=; b=jzRi40++qm9IKV3W
	DFhl2OnAx5ljK0yTl5sdGb4NA1HEADBLS++TGqlMn+WPdwX2/6sEnm3lmv9ZYp99
	LlEcReCx/bYzwF9NLAtO7bcrJFlciMJRn4aPd4eD+Stm98eR/lZ9R/efJuSpDVl6
	p4AC2qFIxVW4C9vjed4kHsoulcpLPjlt7B+SFd8FKtUQRBzBx/9/HZp7wa0xKWjF
	8rM2KO4apJFk/+YVNR4yaMCdO560y5Z1GaPSB3DeLIl+du/7wdBMFdHNxChQbTN3
	j6zhYqIDgiwDKkVDo/UJGD/sin4FGYQlmLRq69LZ29Ly82bOVP73uBopj5ec+ouI
	5qGwVQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj82eew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dcd603855aso1696012a34.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479749; cv=none;
        d=google.com; s=arc-20240605;
        b=YXh/HZUmNjmatNh86xXPDJCMgepk5E3my6eYIoX2g6vAvcKfb5h7WYuUri3oYC8zpP
         UmgSqzUoV6TGBFw0xp0GuuunUQvwy3U7obbVxQb2pxorFKTIreDjKseGzbcrxk5Ussta
         r9gOzuU41zd8DthnMMfNIMSZbEKHYJ6Wzb9/oMeV3/YZwehT1l65TDEEEWsP9E8RZeSr
         u6M5ZHhmsBDBF8eJ3T8Ar3vaPX2CJZ7Kt4+v0aTi2wCl9VITgcewuFPVMs5Cvb/Mfgdb
         kPGQkmcZO28mmYyys4Df76oxF8gvAkUQoRLqhQ4YEsCHEBHEMqui92paxUGiGLQTpisx
         CTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        fh=wx1IJkYbXsxAz/mYm7K3RGuR1cmamzRaeuViCH+mLeA=;
        b=YOqpCD/tXBX8eOkuICPlQBD1YLkBTltC1ORbQ0X8CdIcT+btVM+2m3o4/YQ/hcWbk0
         VJJR2Arj+HnqaaRUaU0R430h8y1Pr3GNfcPp5EMaq6BSAFYayAMwTxuffDmbNQAyo7ov
         LoOdKl5jNigQVk8IFmt+PL0t0jJ/qSQZh/I7guxNTSNQeIrQz7fAnk1E50V/6MdKPQq0
         KhFzclYTRNrV92eSaUunk9036zvjNoxY5F0PNgsuRT/y1Ne6X6NGmLEJS7tcHzL4lgZI
         OgYudBB2rYJTSnfhVmDa+XdJpXalMpkjUZV6SxkHPqf4US2EjEdrcjlAIiQRsQ6WCNCC
         bXag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479749; x=1778084549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=GkK2GDLCkQqfYx6JvKVq9FxU+hMrvsfGpUfPRavqDCLTUpLBKUdKe5rLsqys6FDmtP
         hIOvvEfK9Q6faBvDu4cyfg+UhizleVr7xWuPGM+/O/Smc7rzLbfFpORp6rQ6R9u9TB42
         YPliTBBJ/jTM060xEkWFeIHanPsz3QjsND1QRwNRc75XReEhwvQYDq/sOJ5sAZqqa09m
         mGS5XsOIV6arpJMMcEf7lnuj1cFn5E1nVJlL9a//ZJIk7eITAA7hTvndy26W2QBSoky3
         Dia8pdzWoCz5Ns+Xld2S5VTzXxMwdwCZB56H5G8oStRP0rifd4r3PNpyuomi6/FBTwRr
         emew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479749; x=1778084549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=ieQLhtUXTFPgth135DXchCAeZharsLggUQN7O4zg/7fTZNTA6A0+aGFz7N2bNQRC9W
         3o7L3b/+mXbwrouGlCABmiMm8iEHrH+ZRuNOtVaZ9GOu/eDf4rMfdqfgZ1W8JLGuUMzQ
         KupK4gY20G0qXn+s/TlQzeTv/QOEyNacuNogaKPWxrv3iVPxe5EvjUxMyt1JwrJyEfDx
         kS1r6q3OVPrq8u/R5uEdX8kBRFVvZKSsjDz9CjoYiCOJq3qbDPm+rflquDZqNpH6MZeE
         2JP3J1aqobeF1s0hNce9BNO76oYfmECuU/MbqNtrXL4sH3lHH5N/RtVQbs0a81TPMa1l
         ++Ug==
X-Forwarded-Encrypted: i=1; AFNElJ/7OjYMs1Ux3jzENL8v75A3tVOElHse3jtkS7qE/7CT0vVGnSCFoUXQ06im84qVipEk2dlX7K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTn/CxSMV22BLj+ybeZ8r26mXfKAnzRfjycI5fPVw7g44OrAB
	EHFuCGQHiipUnyceAU1lLngorEJyfqhrMG+GkS263FEdCgPpOwsI7QaCTrBTWfXq0nkp9kCXhTE
	f3vIIJmRQdvnQV5RWt4YsB1H7FVwbIPmMEdbpp0qQzdzyN1OjFW2oB7XoYC5C9duBSY8BRK0Q7v
	aeqMkZq6vldta3uAXFcmbdInbEjHguQuSJQw==
X-Gm-Gg: AeBDiespL2nBI/TwNSh0Sk6plUVhHSdZ8Sm/rRUtYpFFr7NWkYa3j5j52IArr0ga+zN
	o8pZZkr0OP+00NjyNc/4mHsok+9erRqhyLZHAJFR4+E5paOHOriD2LNzUBt2vSmA7o8ZiD9KR8Z
	RMK393RuXr8tUSR7ObmIauCH+4XhbvcQiaVjxzbscWeTmFhTkzu2gfg3gdPFFsbTldBEi/KkLdk
	3jMfGI0ye2pJ79KQ+KIsSBaSMLUqjHv9/0oDNpOWfW1Hnleaw==
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id 006d021491bc7-6966e288f89mr732625eaf.20.1777479748845;
        Wed, 29 Apr 2026 09:22:28 -0700 (PDT)
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id
 006d021491bc7-6966e288f89mr732600eaf.20.1777479748427; Wed, 29 Apr 2026
 09:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
 <CAMRc=Me9G9vd06a39vi_UrXCTkUtJQRogm2MqgnwLS_r3Thyzg@mail.gmail.com> <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
In-Reply-To: <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 18:22:16 +0200
X-Gm-Features: AVHnY4IKbhM_HKhU56A0ru1z2waWryyeh9i-sfRAmlk4QJVuWsNhvXilz3QVxic
Message-ID: <CAFEp6-26sVj21JVECREORdq+UeFTB22MoqAm6Pd2fTosCQau9Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: r2ta8biyhX02w8wzCxJTOLRWVVDlYzoL
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f23045 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=J1Chn9sQg74BwZjCRdUA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: r2ta8biyhX02w8wzCxJTOLRWVVDlYzoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2NSBTYWx0ZWRfX7svMGeYHNNYr
 ayn3ovbNHDadyNjWQauU8F0W7dZvhZKeKIddqHQuMYZreWCSen+radJvqH4eZb25JUTqkbmzlR7
 CKPOUD7m3dfgll+gPCoxVIDvKVZjUTyzUGaimSivntoBQFaKP+ayGfZMK2ENptA38YHmmkyl2//
 iMmuEeeulL6M3rlzuS8unbcmCuMxUe0GbO5Pv3Ad2nVbqszh/ez54FEhr1o/h+xpY1BDgTtUQAf
 7vhXtHtxbMaj3Gpt7w3eVKqKrPHXF0p/PYncb5lxBDddQ668mcEBxI9or9QvALVmGKmej88A/Fc
 /LbbNpHuMYOAW7T7YviXZcEqcJNWjGvGuxAX2h0ge7Uc4Dl5yzh/XVC3O2OH91+WWlJBq9yMWCR
 SdnfS5j5+L5vWRARagXMaAJgnssVRgpkxL4ocvYei4CqqzLMlDfkwgLoF2fU2YvKaztUumrvqCy
 iKMkCctwDHFSWgXDlzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290165
X-Rspamd-Queue-Id: A0E74497BAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282436-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim]

Hi Bartosz, Andrew,

On Wed, Apr 29, 2026 at 3:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 29, 2026 at 10:53:13AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 28, 2026 at 4:23=E2=80=AFPM Loic Poulain
> > <loic.poulain@oss.qualcomm.com> wrote:
> > >
> > > Some devices store the Bluetooth BD address in non-volatile
> > > memory, which can be accessed through the NVMEM framework.
> > > Similar to Ethernet or WiFi MAC addresses, add support for
> > > reading the BD address from a 'local-bd-address' NVMEM cell.
> > >
> > > As with the device-tree provided BD address, add a quirk to
> > > indicate whether a device or platform should attempt to read
> > > the address from NVMEM when no valid in-chip address is present.
> > > Also add a quirk to indicate if the address is stored in
> > > big-endian byte order.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > Is there any reason why we can't extend the existing
> > of_get_mac_address() with another property name and use it here? It
> > already has support for mac addresses from nvmem.
>
> Does it even need to be a different property name? Is a bluetooth MAC
> address somehow different to an Ethernet MAC address? Isn't it just a
> EUI-48, independent of it being Ethernet, Bluetooth, wifi, fddi, token
> ring, homing pigeon?

In terms of naming, I followed the pattern of the existing DT
properties: for Ethernet/WiFi there is mac-address property, and for
Bluetooth a local-bd-address property. So it seems reasonable to reuse
the same naming for the NVMEM labelling. Also One thing to keep in
mind is that Bluetooth has historically handled addresses in
little-endian format, while Ethernet MAC addresses are typically
stored in big-endian format (as far as I know).

That said, a more generic EUI-48 identifier could also make sense if
we want to go in that direction, with expected property/nvmem-cell
name(s) as parameters?

Regards,
Loic

