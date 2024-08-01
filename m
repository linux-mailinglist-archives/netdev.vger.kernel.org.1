Return-Path: <netdev+bounces-114967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D6944D13
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333B428689B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEC1A2550;
	Thu,  1 Aug 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/JL1kxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0F19F475
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518561; cv=none; b=DPrIbx0f1CxsZf1YF8Ut6l5MLl7gcoWRc05Tb6fPXghF5qaZir7VTF/oMIsmVRMsIJ2oYWpEFxvW3Yc3tJobc2IhDSweBXXcM+xzeWj/5AyITT32si2cJtIS9S3GEBWCVWc/UcADIN448wJqZsEHFk6ooElGnauPS5uzIi0L+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518561; c=relaxed/simple;
	bh=Y20J57wKy0m63A0IzEwUS1Z23god9136crt0lquULNw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q9BtuD9q0jxKbQXR81tU1EU4xt5kEn01lFFnACfeUtss8GJCg8w0SYw91Ar6wSaWC9rz78AbCsLCVQ7X0HeQoYq83dTS4snpuAdnRkemr9wgpFWc2Ymba5BRQvLRaeNrMsr9EfQcjaPhS6+rCRGiS1KiJZWjj/SXuVyofh4IaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/JL1kxn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d0ad7113so471859485a.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722518559; x=1723123359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPSnMFa01nwSwnaTpruIsVb8bySoRkiy8o4spo7pR0E=;
        b=X/JL1kxntPugwvU8Kx66R05N7O7ssBrvuGHUSu97RpeaGOGEQej5KqBlGkQP1Svn4+
         ttA4eB4y1XmY1Rg9SmANucgb3P3LQqcZuPN96Z+I1/6RAGN/MFcb/7Y7L5dCP/wJmOdj
         Bsa3cWDh9XxpAPbxfqU3iMRt7FV7qdek9KB+R6rXM5lcrMDXY6eLtUHRtJb81SU5O92V
         6M7k77mEQRzt1jb+EeL0x+NGosWOIDUNDIs9vGopx3homStTjSpe81cIoV3qYAFOMVi6
         Tt8CwN4hVyKLgQpfCsLIUc5QWqA/YWjkvVQvaeSfpkUq83Qxt2/GbgdjCHWGexdTcp+P
         BHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518559; x=1723123359;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPSnMFa01nwSwnaTpruIsVb8bySoRkiy8o4spo7pR0E=;
        b=OWrcbphii8tupk9d8SD4YP0+9IBZRnmgf9CMoKIt3/W2frG+qTsUXlNRLUbbIvHrhV
         GfQaYfrKJmEANJ4Uxa+Etr4D9uSdiFqCWnB4K4UR6gKkZzk6ImrLD4jaEeboVaKIq0Ci
         PXGsvjgGiuCjNjSpdUTb7p4gBL7WjXTaH2yhUY73u03DS6hAs3yDduYT4TiA2gcihEyg
         +sph20vexN/wETtBIItFIk3ZegjxiXRWJo0sa/+lgzu04wq/n/isUsfIVC8WhPEIpK9L
         5Yvc/AWB7ZgEZh61IEkVHF6cJhAQZE6Q12WupXNnzvZygClQ4KAa4yXYY+UE5m2By0Me
         R/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkUZ9lMkw8ya9FCkHPZvBEFErCLG6E+Tl8QHrMHk60a07KZwL4nihl9oZLPPMw7f+W4HZnkbRO5HbGrtq5bHPvHOXByteF
X-Gm-Message-State: AOJu0YzFVb896ukUGzM65DNF6d85nBTC0Q0KhGGF8eBz0tfwgjbU/mnF
	KUoy826fQnxSyL5cZaX9Z5yPi+4PWZEi7CWGCa/Eyr8ZHK1NTEbj
X-Google-Smtp-Source: AGHT+IHpGRTRMx9gN6MhMwCpRTSO1RScqU6ITvzbDIJpH6F0SytRwsGitr8SmYRWUPH7czJq6wc1+w==
X-Received: by 2002:a05:6214:4a02:b0:6b5:752e:a33a with SMTP id 6a1803df08f44-6bb98432ce6mr539076d6.57.1722518558727;
        Thu, 01 Aug 2024 06:22:38 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f941526sm83165446d6.69.2024.08.01.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:22:37 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:22:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab8c1d6e343_2441da294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-5-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-5-tom@herbertland.com>
Subject: Re: [PATCH 04/12] udp_encaps: Add new UDP_ENCAP constants
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Add constants for various UDP encapsulations that are supported
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/uapi/linux/udp.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> index 1a0fe8b151fb..0432a9a6536d 100644
> --- a/include/uapi/linux/udp.h
> +++ b/include/uapi/linux/udp.h
> @@ -36,6 +36,7 @@ struct udphdr {
>  #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
>  
>  /* UDP encapsulation types */
> +#define UDP_ENCAP_NONE		0
>  #define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
>  #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
>  #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
> @@ -43,5 +44,17 @@ struct udphdr {
>  #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
>  #define UDP_ENCAP_RXRPC		6
>  #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
> +#define UDP_ENCAP_TIPC		8
> +#define UDP_ENCAP_FOU		9
> +#define UDP_ENCAP_GUE		10
> +#define UDP_ENCAP_SCTP		11
> +#define UDP_ENCAP_RXE		12
> +#define UDP_ENCAP_PFCP		13
> +#define UDP_ENCAP_WIREGUARD	14
> +#define UDP_ENCAP_BAREUDP	15
> +#define UDP_ENCAP_VXLAN		16
> +#define UDP_ENCAP_VXLAN_GPE	17
> +#define UDP_ENCAP_GENEVE	18
> +#define UDP_ENCAP_AMT		19

Should these existing constants never have been UAPI to begin with?


