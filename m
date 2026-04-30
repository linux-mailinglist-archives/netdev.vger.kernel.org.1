Return-Path: <netdev+bounces-282855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOxNIapV82mLzgEAu9opvQ
	(envelope-from <netdev+bounces-282855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ABB4A3414
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81D5B3034EC8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2841C30F;
	Thu, 30 Apr 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wv4+57bH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwcyrArf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B23FE640
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554810; cv=pass; b=nG1j4/XR3JtM3/m3lQ6VUEAZ24zOOefuyotD88bhClbU9EaAzP5RAwgwvMxDi/FzRUgEdEd9567SDxWTYswp0HxX4nswPiyZa+YjKq6OL2Qf46QUrzJgB7/7xBZACDozcCTOUf4xkRndcuu22PrJegvO8HtaASaPTN6Ahdntmak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554810; c=relaxed/simple;
	bh=uOBwc+Vl17MdUv77w9tKQsD4/qPdD6T614WQexS4A50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny5mZHmrFv09t7UlGQVdIDz0m8my2SQrLvCe3SzKZdMMaJNPONM6H4DlvlZ7COjF8AyNsB32awv/2CLL/mL/Q/6jbqfk46MUtMmcqm5C5iVHDZBSNTedWJjeEpsx5PLVZIH7T2G/nOOKP8/sPtOkuWgLlZNeEmLetJ6k1PYzCQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wv4+57bH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FwcyrArf; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UBkDwX1820572
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=; b=Wv4+57bHKS59t2pn
	l788D+Bh3SNVywmZLGOHfFpV5gix7UmN+Hbdo/rkaV907faoB34D6MoaRtws6I/F
	v30P+s1u0dEaN27jtCCPCVVP+r7L4EEy0FvbN7cRN35CSHU9XxqTb32ZATl5T86t
	UrmjKIcb1J8hNdRzni/k+tZLpRqGXhoJRr92bkpFOWRdgTmqxOYvkyjH1cO6GXnx
	iRe4KV/oP4i6FXY0oe260zuknkGUSwIURJlJbrNK3gxPYKc7iPfxfqQqhZFkUzNG
	0yB8b1v+rCFij5Gpwopcwf+oxHOaJvlbverrXg4+0dPQ0rN+GBwkFpQ3zascOloc
	t7rLFA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv6gerdax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64eb0bbab48so1910929d50.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554807; cv=none;
        d=google.com; s=arc-20240605;
        b=KNG2q289IW2BdtwSLXacAtfxuLv3EJJXwttdnQztRv6fQB8gimYUqG7St9NnQVSjIQ
         GAMPPYwI8cJYY0vcjwvlMI/p0Ikaoai+35OLJ869NTCKytYTJRWHKHPBULlLl4a7KEV5
         FgDa6hvHDTES0XeTh5ZiAk25gjtqXjMDoRK0c+TLxlQ2BqdZIWRYdkxUzfhDzhHJqwb2
         Pmsy7dffcda6kokEXs2RBymffHkLZEd92+T8sqDYUQbEEesLjn7rY4Y2dVHAEGXUP+EG
         BvTBjxZ7JcasH4FZycFsracx+Omg0Mno9KHWNyltPcQwKwfaUZIjujAIOli+f8zVFsKn
         OdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        fh=ZqjMukfP0RpgRYGBwwegXyxukcuYHK/fGrprw6FNMiE=;
        b=cMGFwjPFmd/ktYaEqZ3+U6f8ioW2nnSMLb9gsetc6ib2d4eGqFhw0jT4HUVIJKa3eD
         rz5RAWXpsns44zWNP7BU4ttSgg6I4GcYmJ+N68uPrbVRy9QVB56pVvdpvWexyruriLER
         IYfcMfPTpWcHSIZKp1gpQ6VdK3FAg1R/pfshq6QxEJzHrvi4S49s78H0n+zZaKzMjzI3
         8GdIaU6wKrKxqKLb8FpD9zS1XOOcJfSuZ26d8bzr+9ZCO93IP7RL4X8q0uCajyL+TQbN
         QyoYgiHQnepStHt4o57oakV/1Czf8LTdpZvjYvYrS26vjqPTOs3BhgcnG/lLxhRaAqiU
         c/xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777554807; x=1778159607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=FwcyrArfxVUEmUhB3u8Cd1zaLyprWFV/8QsAGr64S3i1OKV1YWT5ge6d65LkrBgQtj
         i7VvtXz4aCnaUNAKiQA9yIRIXzjfEDIZTvDcxoq+VaoSJx7Z0sngsyGGBstj8Zvk3Feh
         kPWTRxJ3uWdlF7uGPCQIIJ9C1SFAWMCMuvsid+MwkkbpU6eefPGaUbvLCRJjnsjgxu0x
         3lLI9mQiZy3HPWt8t6c/kcOEehIRou+EqkUsyxNXO1QEQ+p+8pLFv4Pyjak72Qz8q/d0
         VkOwBvmM06nD8NE6SpVnDntC1KIyiiFErPPHhQmuZfcxGiVvQiTSqraGm/aAFjVkqurK
         oXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554807; x=1778159607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=BbCWJFrVnpGM9JILCNG37ARCOFmg5qZM1qvb6loFapVB+U6sCiDTRzjtgQqR4EPJ0C
         gf+3jD+bJ/M4HEUK+gdDpQPQhRw2bWsqQOzPdnhfARU1Z7J0ekAW1jO9rRX1T2BfQbIR
         IMIm15Q65WY2EaCfZzRnqHgKlGx8xdu3dShNtpFq0uKL7MTTz1FSlWu8LD8SvM1mSG1X
         9obj9fahG7eNM1DY4jNdBk6bjmzTtlN8EZlBdccgvrf9Uk3P127ABFuOOz/UAllOUTbg
         r87gBRlOkYSjNKtD16fZSE2u1+SSZ7axp9U9ddRo/8rCcW9kYJDD8X86EK7x1SPcRfus
         uY6A==
X-Forwarded-Encrypted: i=1; AFNElJ90lzjB4KxvKM6lUzFtFGxJtMLOl1s/v+49fl8Ro8pLg0gMgat2Z3+MYXwK1/+5tf/NnAaSaGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/B43kTEfwJMyB2aM+MsvuCy9G+eGBAavgzFQDkxQj+WZywem
	ZNEg+48lLzbJm9kqwwgykNmH26dnS8FEC9SJDn3UQiKLaMDTnHvX3bZpoo3KauEkkuKSsNX+Fj4
	pHNpfOiq9fx80kYXA1WyeqL5OZ5crdhvywDddpl0ujDhivYHi9r+VcSUxENxoPz43JFLdSHdUmb
	spO1RjunQi+GaAXSPbFCOef8V0UL8vkx6K4A==
X-Gm-Gg: AeBDietfU2eP3hra73SVzeBNpQ1bbP5tByCvPvnQaf0El8WwTnK98oWHss4X4r/EhZD
	s8HxRzYirut4MZkCrKwkndR9Ag3dy8W1SmZrT94JUpotxahBX0JFyTekq7Q7ZzZRPBB/Kd5+iK2
	MBgIhbGf8Gek/DHuvde5P0LUcBVj6Bq7E69JepPV+/DSsiOeo+01tx/NOT8ptn4emX91S41fmgF
	3B38gWV6gBAy0Eskc65f+sBCuOdX+paeZstXQpvHuHreUuToBY=
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id 956f58d0204a3-65c1b0a4185mr1181510d50.27.1777554806652;
        Thu, 30 Apr 2026 06:13:26 -0700 (PDT)
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id
 956f58d0204a3-65c1b0a4185mr1181471d50.27.1777554806063; Thu, 30 Apr 2026
 06:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com> <20260430-bird-of-sheer-ampleness-744e7f@quoll>
In-Reply-To: <20260430-bird-of-sheer-ampleness-744e7f@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 15:13:15 +0200
X-Gm-Features: AVHnY4I6bR6fdSxJnXBrJdTY4FKOp8Nu9g27U_d0aw_5w0XdML8zMEtBVrvqIXA
Message-ID: <CAFEp6-25Xad_LT8L-HPpOpXf7j1S=Vew=iSgxEmAHd_on+jkcA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
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
X-Authority-Analysis: v=2.4 cv=f6V4wuyM c=1 sm=1 tr=0 ts=69f35577 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=Q8QnmAOcOvJ-T5SqZIoA:9
 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: IrvmQu4omyGrTlHpIcpDwPjaiAnL0yDm
X-Proofpoint-ORIG-GUID: IrvmQu4omyGrTlHpIcpDwPjaiAnL0yDm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEzNSBTYWx0ZWRfX+mkqs7WVcR2j
 AkAfYDAq5bR34nc52G4OJWUGon1tnOCeFXX4KVFNW8mIOztuIgNcB1RGXzKjhzHuLyP/pcIZRs/
 kt7hGWj1OtWc/ZHR+FMGO+hac4bBjHjxwx1DsAFPS9N/IKzEUGtxmbIiiY+8Ttqh193dOfPwbh2
 SwowmU6am2LSQuBcWAgjeOc8TRM4vXcW4uS/uCV5BY/Ka+/u8NNbxLAiTyelmPuKpQnzvINTIWd
 SIX/skPRF46JdD++lNkwdyvJlDe9Kb0EDDhaAuByYaJrDUao7PmREQba4sDweDvF0TkCicIUJI0
 pzoNCtgu56meBwIb3yfVWLi8zwiCqaJfrdtz2weWOnfl8D7gF005YIgQ/t4j7/nEHrx1SuSo2Ab
 9jVuGQ4/V8NB+6zukUQLsvXtKDkr49wp5pekZaMtp2L8R97kCKHJ0ieIgae0dj9t0rZaf8Thmqr
 19hqlpuPQrFqdCa9Y4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300135
X-Rspamd-Queue-Id: 40ABB4A3414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-282855-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.17.48:email,0.0.21.24:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Krzysztof,

On Thu, Apr 30, 2026 at 11:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Apr 28, 2026 at 04:23:06PM +0200, Loic Poulain wrote:
>
> > +                    compatible =3D "fixed-layout";
> > +
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <1>;
> > +
> > +                    mac-addr@4400 {
> > +                        reg =3D <0x4400 0x6>;
>
> This looks incomplete. Why isn't this mac-base type of entry? And how do
> you address it from NVMEM consumer?

This indeed falls under the fixed-cell/mac-base type, thanks for
pointing that out.
NVMEM consumers reference these entries using the nvmem-cells
property, via the corresponding label/phandle.

>
> > +                    };
> > +
> > +                    bd-addr@5400 {
> > +                        reg =3D <0x5400 0x6>;
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.34.1
> >

