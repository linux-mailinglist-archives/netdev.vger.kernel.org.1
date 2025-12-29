Return-Path: <netdev+bounces-246288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D2CE81FE
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 21:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7745C300855D
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A40261B9D;
	Mon, 29 Dec 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KlAdv2ub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TtNdLZOY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2A23EA84
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767039711; cv=none; b=WwPoIWKS7rew/TWIBna6GiMvujVxIxY4Ih8wgegbPxsQVd1y6kkLz3DeFpOpBwJWAA1BnK5tn+ijPrbYa7IP2UH7QM8EpfgFXzxDq3b967e+FdFpJfAggQ8A1p7La3xn3GYaQ9enHzn8zj1GSusylta8hDOLNVDZf1D/3/wdgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767039711; c=relaxed/simple;
	bh=fQyhbdxLu2Yr8h7IfuKXCAVZ8vKSkQIrn0uwbz9tiK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSjkUOx13KINxgrPlU9KKYRB+AkAtNocssvEFw+ZVzTNNj/sgdOMgUQFqFkkNOZ9SUqTrYWUVC6yfMDUYnoDRFM3CTJIi9VgMUOWILiTw/9fHzBMqkP+E6qKtFhXNIIz+D6CArhHvWclIwD7aVH4cxJh7VbuO/pmev4yN9V1Z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KlAdv2ub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TtNdLZOY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT9vIUJ1348132
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 20:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dpoZ5UGiip2J0KzaYSKkI3NnTZPsWCC7W/z4CEwTEwo=; b=KlAdv2ubMWttmbER
	zK1m+HlhknlB9IltkrkURme8qcJDFJ+ZfDlbtrT4bO63ZP5p0yx+Yt8/PEmB7e22
	ahTfq8OgZvlgXY/Fsb8iq2Hnn0nKA7XFrPAgv5htE3T0qjnlfrTng8IXvQR38wtG
	dyS4TuVPF7yWnkc9+GkWwkgFnvdzpeOMNt3YbmgDgTpzxZ6IDNNMTu7cVEt0ApYd
	RQLEh2PAj9p1gENTP3jl3g3yILavYaUsbAem52ycezS2xmen9DpZqC0OGQFJUvui
	8gdV093GMKBOXuEyX5EfYy6KfwRshLAHXVDpYwIjScRmISHmwSoBA6hGexuUMRA1
	OFlloA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj3sxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 20:21:48 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-11bd7a827fdso17720218c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767039708; x=1767644508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpoZ5UGiip2J0KzaYSKkI3NnTZPsWCC7W/z4CEwTEwo=;
        b=TtNdLZOYJIyCM3BRagsAIL65UZIsoge8QquqZm/AqvL2MGhhkIR+CYPxHn+y4F5jbD
         3rZwwQYu/xTXo10KjfjlkxyU/KE1FGwhCEdHRRniFMtP4QiGDMfVpVBtWdSKRrKD4mtZ
         BAN1itOqJgJ4UOBA5BhJIjI/LOKSv7FBorm6GIYfSsw5Tu+8272U3gfRRLDkJfTIix3E
         BKfH/JJDuPpkwT4/OFGwWzFgrMoc0oBjtY6yU1C2iuGlKc+wrFwE3mlNnzSqqnQvVdbp
         B0qoZIHVrdDAHaha2jIrdtfnobTJaEL/5ClCOCOi4ZnrfVXdOEGK92G2VDaNYESxaWQ3
         Vmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767039708; x=1767644508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpoZ5UGiip2J0KzaYSKkI3NnTZPsWCC7W/z4CEwTEwo=;
        b=J0kt21f9Gi4gZOUsGfgtrau5R20YYGGJwgxe3kINVVtH7xSs5Z4bAOtjsT9t2yUuC4
         DBXuohNweyuN+gXZFS0iAERBMHUzcfi7Wdk+XQoM3OwAtoA8qJJrn+JFtlgql4cAWlvx
         7p2UiX2MR1EH1womao6JxDdvR9swC8X2MlVT6NQilMURS4ToT7A/CidE2CqVkRDuX7PA
         4caWzEb4WK5V1DVnzothHM2PlSQv6ErgNhLI67Q9c5d43Uyb89O0VAH2HGOJB0FSZl8l
         W6oy5tThxYP4OKY61vaWbKis/S4SFkoxY3cabLKrIafypYUfaQJLiJRmBjGfsuALutjJ
         3JEw==
X-Forwarded-Encrypted: i=1; AJvYcCULMuLXOhPCSoL/aG3dsE5UYoGVTCz7x4/G2M8vkTE27/grbW5W3qhGaOGpDopR1cn9zsemZ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LKFCp6/pbLvpq7KfXIEVc6Ydtk1rn56+w4psi/0uAB2JR0Lx
	N0rmP9m/pp9Ddwjg4BJCVHZbl5KA+yapJzJS7vZpD9ZvdfIntDGs4udPFg123BCAG+/200L0xoc
	ctFy/GTtH3ThdWhYj1FzLQetG8deN8oQUZB18GMkq7xUP0ZzpgAJugEq+4L8=
X-Gm-Gg: AY/fxX4dxkiW04GqbqqjpnDWdERyrcqBUofvNYSIYu8h6pLM4J9oHHk5ImTueZv5cBp
	P2bQ2b+e9e3eEYY7UFcSDLcvwTrIBHl2kn2NxTqvlsVDRKNyO6OeDRJuKl89lMcl+I68IbUmABV
	Vfb1iGgRS/xvHeIE/U2rI5oplFHuLTEFJpqxvsp7G6j+6av675Jq0C4kG2NI5OJ398HzRyguzN4
	/BObjTpYA5mXkna13ZhXcDQ2sLnwgZFTXjg+uErz333qP/UVONYhyBkm3gl+0i6vi2Jr83WXsqY
	SI7LHJJVSzs8cqDgs2VQurauejmd7rEQNhEUUEopqd28ZD+GP+POFYG/SpEj+sjJk7d1gdKl5k5
	i+uOYipg218ucEhEIBQV8YBGG8yIr+WqJyH9UYqD3GVX2Hb87l22D9L9+NE3qWko=
X-Received: by 2002:a05:7022:204:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-12171aca672mr31221579c88.12.1767039708186;
        Mon, 29 Dec 2025 12:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETQHo90sIZ9Ah2oFCPURRgJ6JOFVSXKLGKjyL2O2wo5JOl3Bs3GTMtBAiIr30Ft0lRKlNsqA==
X-Received: by 2002:a05:7022:204:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-12171aca672mr31221563c88.12.1767039707617;
        Mon, 29 Dec 2025 12:21:47 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm120318362c88.5.2025.12.29.12.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 12:21:47 -0800 (PST)
Message-ID: <9e6d2c54-6c63-4cb9-933b-3647c25fe72d@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 13:21:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bus: mhi: host: Drop the auto_queue support
To: manivannan.sadhasivam@oss.qualcomm.com,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
 <20251218-qrtr-fix-v2-2-c7499bfcfbe0@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251218-qrtr-fix-v2-2-c7499bfcfbe0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8d7GxDj4QuXAnfWZjuHCjhcE9jSEfacS
X-Proofpoint-GUID: 8d7GxDj4QuXAnfWZjuHCjhcE9jSEfacS
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=6952e2dd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gPICEALkPRU_h5exja4A:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE4NiBTYWx0ZWRfX/ZDMAE+aTbyJ
 /Jmsl00aYnVj8ZiU/IO2d6ePdC/V68N5f5RXOHzOTuTZO0z9EfVEpMw4DVVYTUciLYnuUW7vvaQ
 QH5K/sz1COcHq9YgQB4EVg8hw0NfBFMYqTY+KFfurlKOjNh1ya81McmCYIdij8OUGpw6DzaWs07
 8Fxv/zI4xYPmnP4HrjrNQVzEG86UK4fHoSPy2QOM+6W/SFFGYXMgoyZCzv5LRr+N7l1bP97x7pK
 p48cxeFTWWldxXxCmY2oMJyCLaGpqoGdCExOOnPjtk3mjRliSQ8iL+2IqpSgxYbYNeHJfM9FYXC
 ZBhB1mbDx6ZIsbNIybuj2QoTKzDKlRs95D9QXlVO2pWTljv0OawijY6J47/DiuZlnmJHFd2aVmN
 lkvHMTAYDWrh5vR7Ll1ybasM2C34YtzC5yHax0aZia+jWV1KI7ORfqmFzH7wNPkKBXC8CNIhmNp
 oJsGf9FzX51s2Yeus1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290186

On 12/18/2025 9:51 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Now that the only user of the 'auto_queue' feature, (QRTR) has been
> converted to manage the buffers on its own, drop the code related to it.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

