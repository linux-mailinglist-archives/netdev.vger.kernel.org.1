Return-Path: <netdev+bounces-229754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A09ABBE08AC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0A9850720B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8D30649A;
	Wed, 15 Oct 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGRCPYyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B92FE57F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557814; cv=none; b=nPUnFR/ZlOWxz1qXaulnSrz8WchQy+yZxRPSa1aLLFhysTbbH/N+UWQA4/9zH7hyOr+QFPO6xySm0VWBirwFpahUEAa2XzWkLFaEiQcO3oGTTPgP32aXX5wBoMPWcrPEQhNgvi0v3Z3mWWg+DvRo3M9F6EBou327EL+PeSSHDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557814; c=relaxed/simple;
	bh=qdxdnXO7dfrt8aCwjz8S5Ntf+heP3QOx0qCchHU4vHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwG1dvPQJPpEnxO8beF5yllWD8/gut/TVa2br5ygVLPujAjmX4tYr7q/ZsRermb1Nip8ZMJAJQgKgAWTzWC/JBKofKCaT8Jj+4uVuUmsmyoSG46q6PuMfB/0kIDWWyv0YZz9JfYNZssCrgQTSQOJjAzSUsJAiBVGC3BbU8FdxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGRCPYyw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so309355a91.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557811; x=1761162611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSXtDozAsQRt+awsPY1YKTWWimZyw22+7Ej5rwMZxAA=;
        b=nGRCPYywnL0MHHI1uteOKBetuVuTWyW91iZe7HuxTYY0yFz1+UJFFq1bhhcMkw+spj
         aIf7XFWRfmkdclIJUzY5NjL6rOStIWg9J91pK+w/uvgltcU0TKOyJrFb1sjwqh3tDm7s
         faGtBj/cLWvdUAGP1XgUfPBl+yCCuIEM517EnS88Ij6+xnBjn3D8hhGqOwjZmAMgfhb+
         Dlx0GyfWUqwG7hha4x7dqV8679W8xVDkWMlIfhdQuBshYisNXsOZ+HGlzoBiad3/pUWN
         +8oDDoN3KyD84NSruPM7A2d6eLnpq+xdCX7ohYPZw6yO+hTRV1vTBdHbsUlEGpETU+ki
         Mmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557811; x=1761162611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSXtDozAsQRt+awsPY1YKTWWimZyw22+7Ej5rwMZxAA=;
        b=q5uqnmetCkkkCSePawmlFeosT3xFU2kVhzyUeZruSN2QQgIphvmzIwpqGZAYGE2Qdx
         7+8UH2GTg+v/cfcn5IPi1cl18KXPMmPXNZVDkjXQmCeODOVX9XUNV1LVdHoVAMu8XQRQ
         5EXFDedah5mm1dh0uIRy2havJ+ujfzQbd4Cio8EpFKSaguxmRL7Nj1EpgOWyUbuAC37W
         luZ1DHmlDK2MJmCFjUFym4ALEnBg1fKJtHxe0SUC3yo4Krd80ezPw0ng+sJdKxpjPihE
         KK4p8yS5KxRizGg9MIjQBO6/GlwNNHkTD2IQFDzGvlgOqPA+CuYPTCJHW7hLsQiKq83f
         mwIg==
X-Forwarded-Encrypted: i=1; AJvYcCXbYNIwVObjG5JwbipOH2YT2tWd/sYTSP7Jf1m0yvRNOF8DuS/DlCo8bZUNYk5cNvMGzUJFMBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONl8b8pxXsjHsp8arXOtx/yDgcWPdbpEZomQG4zvIjIAnRh3I
	MLvoGq0WKF97rRcrrKff4QbAZvcH6+T0S6r4m8JPzrIx17jviPpRKH32
X-Gm-Gg: ASbGncsITmVrGsL27X+kkeaK9E7ZKd+2FBKbtUKbGoifXJBSLo6/Zdv3AodCHTkclOk
	ISqmKwQHaQT6R6ViGmVUHYGsVBrKHa2bRLUSdnWE13j9N04N/TW3PXeLvSitK51ujVQQzVfrjcK
	Kcl7qNxOJ88Be6AOyPPBZhxMN1m8CYrLbggYXxGunbJnb6VqGktX94BpCiIBq3knXFzaHMFyfli
	TVhABDwa13fNfT9flk8qAEhcWiL5NoX1S4CDG2ILzU3wvDcPHGOb1tLz/1X7+aXfEWF5LDs2fXZ
	tmbDk6jTm/GbOLMue63FWFlDblLMyOR+YEJmWmvZ/REWI4Ho24HiprpxNiitpNRHPkiddU6VvlH
	9j+T4NcjoNXJvjf8lPdY9k1lommlVpWLh1LUD+lp3smiWZKriVAKL36IFjEa3PozExfqLR1KgO6
	DFdOpM
X-Google-Smtp-Source: AGHT+IGyCUeGhHmi0GKV532SbGwCqharBSRZhQLDnQHs6oWMGcINOpBVl4YWDotX3YHZ9W8I+6d1kw==
X-Received: by 2002:a17:90b:4d11:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-33b5116a3c5mr41420491a91.14.1760557810742;
        Wed, 15 Oct 2025 12:50:10 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537:573a:39d:6287:7ddf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97853829sm3578251a91.5.2025.10.15.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:50:10 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id C835B11A8199; Wed, 15 Oct 2025 16:50:07 -0300 (-03)
Date: Wed, 15 Oct 2025 16:50:07 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] sctp: avoid NULL dereference when chunk data buffer
 is missing
Message-ID: <aO_67_pJD71FBLmd@t14s.localdomain>
References: <20251015184510.6547-1-bigalex934@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015184510.6547-1-bigalex934@gmail.com>

On Wed, Oct 15, 2025 at 09:45:10PM +0300, Alexey Simakov wrote:
> chunk->skb pointer is dereferenced in the if-block where it's supposed
> to be NULL only.

The issue is well spotted. More below.

> 
> Use the chunk header instead, which should be available at this point
> in execution.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  net/sctp/inqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index 5c1652181805..f1830c21953f 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)

With more context here:

               if ((skb_shinfo(chunk->skb)->gso_type & SKB_GSO_SCTP) == SKB_GSO_SCTP) {
                       /* GSO-marked skbs but without frags, handle
                        * them normally
                        */

                       if (skb_shinfo(chunk->skb)->frag_list)
                               chunk->head_skb = chunk->skb;

                       /* skbs with "cover letter" */
                       if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
		           ^^^^^^^^^^^^^^^^^^

chunk->head_skb would also not be guaranteed.

>  				chunk->skb = skb_shinfo(chunk->skb)->frag_list;

But chunk->skb can only be NULL if chunk->head_skb is not, then.

Thing is, we cannot replace chunk->skb here then, because otherwise
when freeing this chunk in sctp_chunk_free below it will not reference
chunk->head_skb and will cause a leak.

With that, the check below should be done just before replacing
chunk->skb right above, inside the if() block. We're sure that
otherwise chunk->skb is non-NULL because of outer if() condition.

Thanks,
Marcelo

>  
>  			if (WARN_ON(!chunk->skb)) {
> -				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
> +				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> +						 SCTP_MIB_IN_PKT_DISCARDS);
>  				sctp_chunk_free(chunk);
>  				goto next_chunk;
>  			}
> -- 
> 2.34.1
> 

