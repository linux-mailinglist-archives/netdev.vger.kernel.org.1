Return-Path: <netdev+bounces-159542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2BA15B69
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 05:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA583A9196
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D89126C1E;
	Sat, 18 Jan 2025 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U20mhNoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BD51C4A;
	Sat, 18 Jan 2025 04:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737174206; cv=none; b=qzanca/waT1fLtLx8YuWelroNdmCAZ+nSw6HLjIOV6cBYt+hK5CuG8AGn/JD8b3hnZ2gvHGB2YzhFqNajx/u0BSM8URsJwUwnv4Hf+r3YQ+UkxsaAXVNvVsr2m/JO85vojElhYBd0/fhtnNpgDEBBx6IrMeIfU/x/UiP5HBZW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737174206; c=relaxed/simple;
	bh=NeofN6KhWIT0jxyaSz41wvwHQUJX+A2/SQUfAXGClqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOfXm4nQDXk1JHb8gykYNcfOdUF1kDKlaDi521a7TRr0/RrAJNLsvt0EZst5amH2/3yP4BkBaM5jDbYqYurSO+NRzmNg7FBh5UhyDJWBhuw1a+Y6reV6Qp77Dai3ytbH27rwn6WiwCty6ZkxJeLl1nvTlJfN3c9Pit1TCbzjAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U20mhNoy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so4016776a91.2;
        Fri, 17 Jan 2025 20:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737174204; x=1737779004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrEgKv/RzSsqg0Cj5XHgdcWXqMQrhaPKLNHBN4Zw3Is=;
        b=U20mhNoydvqxu5Nc1yY92x+e8gTFYFjY/oV5x9SVWq8X5g7tsMKqZUoKy0ht7c5rGI
         NR9Y7+87MDdntbT0VnZKBEKnnYcs7A/9IYeN6Q+lJ2vrK1TkjPZdmmhgESS3fihU50/P
         LGRbt+ooNUnxI6o3TmuhYcaff5+ORa9iZe0sAqT1ZYYIgi/Gd2a8DmxwNVfKR3nMYvXZ
         78wLytN1UgXwSDnCH+y4GLdevjdt+OWDBXUhw/k06+8RZZQjJl18JZNj5sLCDsmBzLEb
         jzpNARRIYXX2nj5TTpufwY6x6UV1whOLtQjrcaUVv7jvC90rOI//FQ52zhaSYQPv26cr
         IsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737174204; x=1737779004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrEgKv/RzSsqg0Cj5XHgdcWXqMQrhaPKLNHBN4Zw3Is=;
        b=MA7UEAQTqykvT6ZapR36CvMOd7voO7Ltdsv833bCRzfBjZSVUbKTxTdw7qq1bmNMJq
         i/qsI8XqnYrTBMQn/gz5Q9ScFP1ZmvXUSi90txWLKPfs/z4iWBvJI/YeVB7cubP2hFmZ
         QBSUdt7O4+H/UNfN4Y35AEbqzi43hIafkcdPRFi7D7iamB5oRCRL8yhxdIz47sHCxks5
         y4/z1eWIOOlNpkQ4xtL7PSjerlh0y6ul6KkuVr/Tk6eebbptmGKR5l5cfzuYzPDb1v/v
         GMuY9p8Ky3kTSJrkZjynvlLhjiQhf25qABkDmw2qJFgdkD5fEar0vfvf1I/9tbBkm1LL
         Ph4g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/b9CjwvRWk9imAhwtpkFYbdtv0MUt5gKlUv9U07wa2vdNjl9ceN6jMqrTa7b2LhdovX4AJmui5cteyQ=@vger.kernel.org, AJvYcCWfle+W6bf0I4Whb9dZU8sRukT35NRSkv0lKJiAzxBcYX7Wa5USEGF63ckBOO+hrwy4UAiE9F/j@vger.kernel.org
X-Gm-Message-State: AOJu0YyzicK2EBRJyf9T8hqz//PWLkIZ8H5GvkPW5ILnnfbRATJgJibz
	s1zBXpxqkAeWMnsuq0h5rM5UQBk+17CpOU6bQo7tyOY1bkeSwaCdk6JauQ==
X-Gm-Gg: ASbGncs7M4Ix6M/Cl8R/yK0pW8b92pq2eKaC/OKgMcNdmjtTx2j9Kp8vdzsc3KV0mmw
	JWgxPuXu8VOhF8OvuyLqzNnQ+4P7X3TPqdQTk2eWwyHuCiQzSM6+Nf30/GTp/QaoZglNo2y1am4
	sN6kn9uysdwfn2+89sIRC69HOFYYzyFH0F3xg/RXdGwCWWZNhAMUsS/rB64IZ0VEcyq1W4Em8Wp
	fWvbi4fRMcyDivyH5MlkauWLkdQQIofrSk4DiL4uXX5XGdLfJQjEr6LJadHzYJuArRqMVVFJw==
X-Google-Smtp-Source: AGHT+IHOd8JRhBB2mq2uKdHt8VHiT9/mXRr/WZQZIB/QzVAj0NfZN7ODodLX8M8LYV+V+vE05p4GBA==
X-Received: by 2002:a05:6a00:189a:b0:727:3ccc:25b0 with SMTP id d2e1a72fcca58-72dafa9b030mr8646672b3a.16.1737174203796;
        Fri, 17 Jan 2025 20:23:23 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm2859720b3a.136.2025.01.17.20.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 20:23:23 -0800 (PST)
Date: Sat, 18 Jan 2025 09:53:20 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: implement TSO descriptor cleanup
Message-ID: <Z4ssuJQc0SClS5uF@HOME-PC>
References: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>
 <PAXPR04MB8510E1BAD3FDB59268138682881B2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510E1BAD3FDB59268138682881B2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Jan 17, 2025 at 02:47:33AM +0000, Wei Fang wrote:
> > Implement the TODO in fec_enet_txq_submit_tso() error path to properly
> > release buffer descriptors that were allocated during a failed TSO
> > operation. This prevents descriptor leaks when TSO operations fail
> > partway through.
> > 
> > The cleanup iterates from the starting descriptor to where the error
> > occurred, resetting the status and buffer address fields of each
> > descriptor.
> > 
> > Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index b2daed55bf6c..eff065010c9e 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -913,7 +913,18 @@ static int fec_enet_txq_submit_tso(struct
> > fec_enet_priv_tx_q *txq,
> >  	return 0;
> > 
> >  err_release:
> > -	/* TODO: Release all used data descriptors for TSO */
> > +	/* Release all used data descriptors for TSO */
> > +	struct bufdesc *tmp_bdp = txq->bd.cur;
> > +
> > +	while (tmp_bdp != bdp) {
> > +		tmp_bdp->cbd_sc = 0;
> > +		tmp_bdp->cbd_bufaddr = 0;
> > +		tmp_bdp->cbd_datlen = 0;
> > +		tmp_bdp = fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
> > +	}
> 
> There is still some cleanup to do.
> 1. If bufdesc_ex is used, we also need to clear it, such as ebdp->cbd_esc.
> 2. The data buffers have been mapped in fec_enet_txq_put_data_tso(),
> I think we need to unmap them in the error path. But do not unmap
> the TSO header buff, which is a DMA memory. Actually it is not necessary
> for fec_enet_txq_put_hdr_tso() to call dma_map_single(). If you are
> interested, you can add a separate patch to remove dma_map_single()
> in fec_enet_txq_put_hdr_tso().
> 
> > +
> > +	dev_kfree_skb_any(skb);
> > +
> >  	return ret;
> >  }
> > 
> > --
> > 2.34.1
> 
Hello Simon and Fang,

Thank you you valuable feedback. I will incorporate the suggestions and 
send the updated patch.

-Dheeraj

