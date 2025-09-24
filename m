Return-Path: <netdev+bounces-225967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095BB9A038
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDFA7B02B3
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F953002C2;
	Wed, 24 Sep 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6CTEoIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DA2E175E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720012; cv=none; b=ZPbNOzJs6qfuRq5QhErxUVfgwsDsLgPsaAvhfr9kagAWxSZnm3VZd3T1FpCUA1DW6B5yeXLpqYDkYgDl8PqGeXxtBoCGquwPysuavM1xL2iWu2L5EF/uJ9Pu3LDFApDKjAxuU6yKiFIxO0Ieor6oxI83Q3/fCzB1TguP+CqA7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720012; c=relaxed/simple;
	bh=SP3UQmEOrk3lXr5hl3AyTEmVdyCNGXVBCSjjJGEAbEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVNrr8fkO9meAcgARvlYpu5/mc4fDvXlTe3PY+eOZbvUjpljl8pD+j+zU14GzHZvT0DP5KsxD3t2oXzD7kgwu7kSIvXJ2ct8UyKvRNZrJ2yFbV6Nj0F3Tz++lm5rYGWF18dtzOKdyiEYw+2BRB05K4K+a3GURLJ9qTmJ+u7BRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H6CTEoIW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f44000626bso2987059f8f.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758720009; x=1759324809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=87JZSBy/WCOIcFr1kd9NSvr63qaN8mpgRLVKV+Vgq1s=;
        b=H6CTEoIWfDrBrLroKxR7sORnRRw9Hw5SAbX9JzpfY9aGdBpVgFahaubv6EqaRP0NAe
         CMl+fkqQY/l5EeX/vuTnDQrOsNDS4eqOADFQpyNwoXvDDr5B6gWRs8czaWjS/nBPdmI/
         MBv940tXsiuoPEqQ5HeTAexkpSGOsGWRUOrM+jIvqY2hssTeJHfU+w+NlRyVXGmqsV8b
         wKgw56umMth+w6u9eEiwRIz2sh66sedkdICsgwZ6K4NaN2DKbXebvOzxBR6SyNiCBOQA
         68TuQxiwYQYhtGW5IIEJgOLMCzSn9BjTwrEveEH221oJgwWMdD77fCL51gFelPWH7KXj
         52aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758720009; x=1759324809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87JZSBy/WCOIcFr1kd9NSvr63qaN8mpgRLVKV+Vgq1s=;
        b=QzQBg5i1yIcwdZGb9AjOl2CwWgub8Xsnywn+6cr7gTHyKe78Qe1OeoNg2ow15NDFdt
         9lG782nQ544vLHsQRVThk/pqHYWl+rdmIUhOyMUL0tzHBAryZVvzPUadT3vJP4ptmkYV
         X+uQMxNl2hbxz9x/7lSrrBNXScLw6+o8SA+AdtNVSkBDqMwI8RDoAhAxgvb7QeVeV5WO
         BuNa+mURUEybUquBU1FvGoOhN50XUp05vclhf1ZEf6mY8vcMH5/+KCv7art6jlwIFmAI
         eY1RItRtwVbTHEXwp+nuj8qk+QIZpmeWiSlsrE59y5dUPItAGNjktQgsFNZHicE2eNhE
         BAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUlOHUoIz8Uwug2CrEdiTe/gHnhXCfBbZkUldxYAd/Wxz15pqN3A6wCm8pK3Ol+HmeJHyubM2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKkyFABsoT3l8+mIz2YMXma/d9uWXSL7180Aryhb3mMx7/IJm
	isWq6dC73nm+YSOLAClJvFrJ2ZOqmqm+B1g7FjsTifG52r1NjydkmVLP6K8nYKS86YI=
X-Gm-Gg: ASbGnctx5wrk/MwGzxZ25StyO3MGdyVKAEP6bF1j1Xu0HQytvcs01CQ0gGJ6IpO9lID
	w+Aso905o5pL0L0bp4nGMYXDJaHpxJ4hxH0iuXF/rwyofYgbWDUNW1J+TO0/qpdj7PTME4JgcsD
	ZWy8nL7J5DqXyAY2tUtmoLGTH565SOexClIlNxmCYNuyPPBUhVpb6KBnPdEbHZ2lwIz65cos3wA
	pDACJzR9NAdQEoZ0hhV40T2Thu1MPFMLXeMTWTzO55lEsfgGr5nNokEkveEX4IOwnNE9Mh8ZUAp
	Q/QElCNJUUZrOrujTahe38C4xrKHRIxdWwuiayIoFevgf57beZ0MYEgt+JICJowic2FpFiTQ4Eu
	zpnA84sYem8EL05Tk3NseNUnl0XtdDSIh4T5u2FY=
X-Google-Smtp-Source: AGHT+IF6QLEH+j1156O7sai1k2CV8hztFA4ENgiawssubuQxs9CIOMLH5mJbfC/ImcJsqWKlmGbDCg==
X-Received: by 2002:a5d:5887:0:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-405c3e27148mr5091452f8f.2.1758720008654;
        Wed, 24 Sep 2025 06:20:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f61703b206sm17908667f8f.6.2025.09.24.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:20:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:20:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ij@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [bug report] tcp: accecn: AccECN option
Message-ID: <aNPwBM5MvpPojt9F@stanley.mountain>
References: <aNKEGWyWV9LWW3i5@stanley.mountain>
 <da87ed1c-165d-fd21-7292-19468d1c8a8c@kernel.org>
 <PAXPR07MB7984BA679B7782C6365E44F3A31CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR07MB7984BA679B7782C6365E44F3A31CA@PAXPR07MB7984.eurprd07.prod.outlook.com>

On Wed, Sep 24, 2025 at 12:25:16PM +0000, Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Ilpo Järvinen <ij@kernel.org> 
> > Sent: Tuesday, September 23, 2025 8:23 PM
> > To: Dan Carpenter <dan.carpenter@linaro.org>; Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: netdev@vger.kernel.org
> > Subject: Re: [bug report] tcp: accecn: AccECN option
> > 
> > 
> > CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
> > 
> > 
> > 
> > On Tue, 23 Sep 2025, Dan Carpenter wrote:
> > 
> > > Hello Ilpo Järvinen,
> > >
> > > Commit b5e74132dfbe ("tcp: accecn: AccECN option") from Sep 16, 2025 
> > > (linux-next), leads to the following Smatch static checker warning:
> > >
> > >       net/ipv4/tcp_output.c:747 tcp_options_write()
> > >       error: we previously assumed 'tp' could be null (see line 711)
> > >
> > > net/ipv4/tcp_output.c
> > >     630 static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> > >     631                               const struct tcp_request_sock *tcprsk,
> > >     632                               struct tcp_out_options *opts,
> > >     633                               struct tcp_key *key)
> > >     634 {
> > >     635         u8 leftover_highbyte = TCPOPT_NOP; /* replace 1st NOP if avail */
> > >     636         u8 leftover_lowbyte = TCPOPT_NOP;  /* replace 2nd NOP in succession */
> > >     637         __be32 *ptr = (__be32 *)(th + 1);
> > >     638         u16 options = opts->options;        /* mungable copy */
> > >     639
> > >     640         if (tcp_key_is_md5(key)) {
> > >     641                 *ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> > >     642                                (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> > >     643                 /* overload cookie hash location */
> > >     644                 opts->hash_location = (__u8 *)ptr;
> > >     645                 ptr += 4;
> > >     646         } else if (tcp_key_is_ao(key)) {
> > >     647                 ptr = process_tcp_ao_options(tp, tcprsk, opts, key, ptr);
> > >                                                      ^^ Sometimes 
> > > dereferenced here.
> > >
> > >     648         }
> > >     649         if (unlikely(opts->mss)) {
> > >     650                 *ptr++ = htonl((TCPOPT_MSS << 24) |
> > >     651                                (TCPOLEN_MSS << 16) |
> > >     652                                opts->mss);
> > >     653         }
> > >     654
> > >     655         if (likely(OPTION_TS & options)) {
> > >     656                 if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> > >     657                         *ptr++ = htonl((TCPOPT_SACK_PERM << 24) |
> > >     658                                        (TCPOLEN_SACK_PERM << 16) |
> > >     659                                        (TCPOPT_TIMESTAMP << 8) |
> > >     660                                        TCPOLEN_TIMESTAMP);
> > >     661                         options &= ~OPTION_SACK_ADVERTISE;
> > >     662                 } else {
> > >     663                         *ptr++ = htonl((TCPOPT_NOP << 24) |
> > >     664                                        (TCPOPT_NOP << 16) |
> > >     665                                        (TCPOPT_TIMESTAMP << 8) |
> > >     666                                        TCPOLEN_TIMESTAMP);
> > >     667                 }
> > >     668                 *ptr++ = htonl(opts->tsval);
> > >     669                 *ptr++ = htonl(opts->tsecr);
> > >     670         }
> > >     671
> > >     672         if (OPTION_ACCECN & options) {
> > >     673                 const u32 *ecn_bytes = opts->use_synack_ecn_bytes ?
> > >     674                                        synack_ecn_bytes :
> > >     675                                        tp->received_ecn_bytes;
> > >                                                ^^^^ Dereference
> > 
> > Hi Dan,
> > 
> > While it is long ago I made these changes (they might have changed a little from that), I can say this part is going to be extremely tricky for static checkers because TCP state machine(s) are quite complex.
> > 
> > TCP options can be written to a packet when tp has not yet been created (during handshake) as well as after creation of tp using this same function. Not all combinations are possible because handshake has to complete before some things are enabled.
> > 
> > Without checking this myself, my assumption is that ->use_synack_ecn_bytes is set when we don't have tp available yet as SYNACKs relate to handshake.
> > So the tp check is likely there even if not literally written.
> > 
> > Chia-Yu, could you please check these cases for the parts that new code was introduced whether tp can be NULL? I think this particular line is the most likely one to be wrong if something is, that is, can OPTION_ACCECN be set while use_synack_ecn_bytes is not when tp is not yet there.
> 
> Hi Ilpo and Dan,
> 
> I've checked that OPTION_ACCECN and use_synack_ecn_bytes will always be set at the same time.
> The case you said (OPTION_ACCECN is 1, but use_synack_ecn_bytes is 0) can only happen when tp is set, because this is already ESTABLISHED state (see tcp_established_options in tcp_output.c).
> 
> So, I would say this is ok.

Thanks!

> But if this is indeed a concern for the checker, just add another "if (tp)". 
> 

Please, don't add anything just for the checker.  These are a one time
only email.  Old warnings are false positives because kernel developers
are good about fixing actual issues.

regards,
dan carpenter


