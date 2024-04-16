Return-Path: <netdev+bounces-88439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1BA8A7359
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAF91C21982
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91CE13541F;
	Tue, 16 Apr 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DGKSTbzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F4132C37
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292793; cv=none; b=FujQyHAv9pp3fQp4lEc9C5e1qLbCAddYRz8FQ3nmCOtC5TIOXVwd0pzPAC/QmGH1PkEnBjuVGRLAy1WfijdOaBQOW4XXtvKyeqVTgAED2+PNVyiVsS1HeIzGpR5Z6fqRJe8lIl4jFv1XcPJBlCvMMg2arel8P1DmHjws54nyIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292793; c=relaxed/simple;
	bh=ZWQjKoriKGbaxG5QPy2UjVQJqUkPupFZhQDotdU5zUA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=abQVKeN5S1TRXA8Qc9cw9ylFLdVLof9h4peE8S4VAmGm96l+43RQXE3eJx9UgEvLjjB/p3L8ml5idU7FCDgIPOs/WL7EQflA89HPT5pzr3Sfq9OSjc/JiDjtq1ZqrXycw83UH9/C8M4y9W7rwmJbLygJ6v3lHfQakuN5efaIlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DGKSTbzt; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a06a409caso23486275ab.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713292791; x=1713897591; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X2o10/ExXSMAnSbsKEbn/5ielT8o7fiwU/kV99vM2Zs=;
        b=DGKSTbzt+zJCo8D946lFgJPzj75YMwu7e+AYvxnxJyrAHWNOVQXYtiz/0SSa/L12/O
         Edq8IhHPPdWHU8Gq+BtkKYzJKb7k84noryhqI0DIYBlbba1uyYGWTer/k3LVcOHmB+Ez
         mMr44rGwj/s3GbcHAB2yBI7CCrG3JTLaAS6srNsYjLGfe8vwgaMgI2s2u2jLD/v2arP5
         MlUvrnsIEOEuS4Ro1jxaRcCCgtp/BoVG5AgkNDmb/dCRN1Ne2o2iQlE01bRri27wzka6
         iCUMz28YSRYbXtLb7nxdu4sQ5XOYbJeK5NgyFmgcjU7F320VjF/rgQtvuaw6WE74LzwT
         8jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713292791; x=1713897591;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2o10/ExXSMAnSbsKEbn/5ielT8o7fiwU/kV99vM2Zs=;
        b=LfHwbpqDi/gO/1/SlzaViHXWR0NA3dxokoVCUrkSIVQ1jrCbgGp07gbfJTO5qI2eWd
         kudrzUfaTeO01CwCZYUVZrdE4AWbxd4gr+4V+FF8HQSeY1yfjt+4va27fPdT+XEcuK8o
         K/jsVW+lL3NMQjTcymF1/4P8EYFlRnso+afNedFqK5SW71XldkQpcsVGvjnvvDquOPaA
         kyEaAwWPmAlIMrdGajOWcT0oM4RSu7BO9OHHSNmpkeBcqSObG3gsOKDEuLgMNmFVO9he
         WlaVuIgVgfbtbBb+xjBebDTLkNO2RJxiM1XmBudk9pPp+tg/QxGrzssvJJN94tjFjm7R
         DIHg==
X-Gm-Message-State: AOJu0Yz/cFN0Wzb1egL2lGFairNC7Dl4/pJQkHkg/DUwkYSZsMsrG/qR
	jhyjchoVKmii1rfu2A4gEA1W1BQ0StBiUNLfrSyOq5GLfH/iRtO9pezLLBPiaeYXLzr18GkLMEU
	=
X-Google-Smtp-Source: AGHT+IE5KeN7lukHwtt5xBFWdRPOPlCRjO3wUGQf4nosFtmr2FiCT28HDESIIDM5M6nps0aF/G8spQ==
X-Received: by 2002:a05:6e02:1a68:b0:36a:1a1b:53c9 with SMTP id w8-20020a056e021a6800b0036a1a1b53c9mr16277246ilv.27.1713292791178;
        Tue, 16 Apr 2024 11:39:51 -0700 (PDT)
Received: from localhost ([75.104.108.48])
        by smtp.gmail.com with ESMTPSA id j14-20020a056e02014e00b00369ed0636a8sm3373806ilr.19.2024.04.16.11.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:39:50 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:39:45 -0400
Message-ID: <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the  CIPSO options
References: <20240416152913.1527166-3-omosnace@redhat.com>
In-Reply-To: <20240416152913.1527166-3-omosnace@redhat.com>

On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> As the comment in this function says, the code currently just clears the
> CIPSO part with IPOPT_NOP, rather than removing it completely and
> trimming the packet. This is inconsistent with the other
> cipso_v4_*_delattr() functions and with CALIPSO (IPv6).

This sentence above implies an equality in handling between those three
cases that doesn't exist.  IPv6 has a radically different approach to
IP options, comparisions between the two aren't really valid.  Similarly,
how we manage IPv4 options on sockets (req or otherwise) is pretty
different from how we manage them on packets, and that is intentional.

Drop the above sentence, or provide a more detailed explanation of the
three aproaches explaining when they can be compared and when they
shouldn't be compared.

> Implement the proper option removal to make it consistent and producing
> more optimal IP packets when there are CIPSO options set.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  net/ipv4/cipso_ipv4.c | 89 ++++++++++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 30 deletions(-)

Outside of the SELinux test suite, what testing have you done when you
have a Linux box forwarding between a CIPSO network segment and an
unlabeled segment?  I'm specifically interested in stream based protocols
such as TCP.  Also, do the rest of the netfilter callbacks handle it okay
if the skb changes size in one of the callbacks?  Granted it has been
*years* since this code was written (decades?), but if I recall
correctly, at the time it was a big no-no to change the skb size in a
netfilter callback.

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 75b5e3c35f9bf..c08c6d0262ba8 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1810,6 +1810,34 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
>  	return CIPSO_V4_HDR_LEN + ret_val;
>  }
>  
> +static int cipso_v4_get_actual_opt_len(const unsigned char *data, int len)
> +{
> +	int iter = 0, optlen = 0;
> +
> +	/* determining the new total option length is tricky because of
> +	 * the padding necessary, the only thing i can think to do at
> +	 * this point is walk the options one-by-one, skipping the
> +	 * padding at the end to determine the actual option size and
> +	 * from there we can determine the new total option length
> +	 */
> +	while (iter < len) {
> +		if (data[iter] == IPOPT_END) {
> +			break;
> +		} else if (data[iter] == IPOPT_NOP) {
> +			iter++;
> +		} else {
> +			if (WARN_ON(data[iter + 1] < 2))
> +				iter += 2;
> +			else
> +				iter += data[iter + 1];
> +			optlen = iter;
> +		}
> +	}
> +	if (WARN_ON(optlen > len))
> +		optlen = len;
> +	return optlen;
> +}

See my comments in patch 1/2; they apply here.

>  /**
>   * cipso_v4_sock_setattr - Add a CIPSO option to a socket
>   * @sk: the socket
> @@ -1985,7 +2013,6 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  		u8 cipso_len;
>  		u8 cipso_off;
>  		unsigned char *cipso_ptr;
> -		int iter;
>  		int optlen_new;
>  
>  		cipso_off = opt->opt.cipso - sizeof(struct iphdr);
> @@ -2005,28 +2032,8 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  		memmove(cipso_ptr, cipso_ptr + cipso_len,
>  			opt->opt.optlen - cipso_off - cipso_len);
>  
> -		/* determining the new total option length is tricky because of
> -		 * the padding necessary, the only thing i can think to do at
> -		 * this point is walk the options one-by-one, skipping the
> -		 * padding at the end to determine the actual option size and
> -		 * from there we can determine the new total option length */
> -		iter = 0;
> -		optlen_new = 0;
> -		while (iter < opt->opt.optlen) {
> -			if (opt->opt.__data[iter] == IPOPT_END) {
> -				break;
> -			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
> -				iter++;
> -			} else {
> -				if (WARN_ON(opt->opt.__data[iter + 1] < 2))
> -					iter += 2;
> -				else
> -					iter += opt->opt.__data[iter + 1];
> -				optlen_new = iter;
> -			}
> -		}
> -		if (WARN_ON(optlen_new > opt->opt.optlen))
> -			optlen_new = opt->opt.optlen;
> +		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
> +							 opt->opt.optlen);
>  		hdr_delta = opt->opt.optlen;
>  		opt->opt.optlen = (optlen_new + 3) & ~3;
>  		hdr_delta -= opt->opt.optlen;
> @@ -2246,7 +2253,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
>   */
>  int cipso_v4_skbuff_delattr(struct sk_buff *skb)
>  {
> -	int ret_val;
> +	int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len,
> +	    hdr_len_delta;

Please keep line lengths under 80-chars whenever possible.  I know Linus
relaxed that requirement a while ago, but I still find the 80-char limit
to be a positive thing.

>  	struct iphdr *iph;
>  	struct ip_options *opt = &IPCB(skb)->opt;
>  	unsigned char *cipso_ptr;
> @@ -2259,16 +2267,37 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
>  	if (ret_val < 0)
>  		return ret_val;
>  
> -	/* the easiest thing to do is just replace the cipso option with noop
> -	 * options since we don't change the size of the packet, although we
> -	 * still need to recalculate the checksum */

Unless you can guarantee that the length change isn't going to have
any adverse effects (even then I would want to know why you are so
confident), I'd feel a lot more comfortable sticking with a
preserve-the-size-and-fill approach.  If you want to change that from
_NOP to _END, I'd be okay with that.

(and if you are talking to who I think you are talking to, I'm guessing
the _NOP to _END swap would likely solve their problem)

>  	iph = ip_hdr(skb);
>  	cipso_ptr = (unsigned char *)iph + opt->cipso;
> -	memset(cipso_ptr, IPOPT_NOOP, cipso_ptr[1]);
> +	cipso_len = cipso_ptr[1];
> +
> +	hdr_len_actual = sizeof(struct iphdr) +
> +			 cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
> +						     opt->optlen);
> +	new_hdr_len_actual = hdr_len_actual - cipso_len;
> +	new_hdr_len = (new_hdr_len_actual + 3) & ~3;
> +	hdr_len_delta = (iph->ihl << 2) - new_hdr_len;
> +
> +	/* 1. shift any options after CIPSO to the left */
> +	memmove(cipso_ptr, cipso_ptr + cipso_len,
> +		new_hdr_len_actual - opt->cipso);
> +	/* 2. move the whole IP header to its new place */
> +	memmove((unsigned char *)iph + hdr_len_delta, iph, new_hdr_len_actual);
> +	/* 3. adjust the skb layout */
> +	skb_pull(skb, hdr_len_delta);
> +	skb_reset_network_header(skb);
> +	iph = ip_hdr(skb);
> +	/* 4. re-fill new padding with IPOPT_END (may now be longer) */
> +	memset((unsigned char *)iph + new_hdr_len_actual, IPOPT_END,
> +	       new_hdr_len - new_hdr_len_actual);
> +	opt->optlen -= hdr_len_delta;
>  	opt->cipso = 0;
>  	opt->is_changed = 1;
> -
> +	if (hdr_len_delta != 0) {
> +		iph->ihl = new_hdr_len >> 2;
> +		iph_set_totlen(iph, skb->len);
> +	}
>  	ip_send_check(iph);
>  
>  	return 0;
> -- 
> 2.44.0

--
paul-moore.com

