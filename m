Return-Path: <netdev+bounces-183326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD4A90610
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80536189B576
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32741E9907;
	Wed, 16 Apr 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkmcCs9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581422087
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812754; cv=none; b=JpEZe0HOYsdg0OcligL6O+WJVqHf6X2E+926JqmHac/YkLGVl8+4C1vD67rJyjnLAk1/rwLTIhtjU5CRcmz0YxzMMqWLCCZvq2XZZ3ZlHxx39fix5eO392/kb1p/J8hVh1xkxK7awFpHe8Nqu5AxQo/n+JivSzEmHPjbuBF1/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812754; c=relaxed/simple;
	bh=2s+qLk2U3a+EzOH4m6ZiaOfpEOAjo8wCD95K5dsr6SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=go1p1P35LNtrML3NvE7YictFIsTWXSivfd+DL0F3+HUarhvh7SL+SwlUz+OAXD8z4pda6sAqpvS5K5571oT2aLdoEywkd42381wuqNP7+5IuqVQ9YyNmfTQbWxOEhdo8D9aGXFGODwNCemjkmZc/EPN4XxuCDo9a0Yk0umFnf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkmcCs9B; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1278280266b.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744812751; x=1745417551; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUYZgkfwAV78Z4x6r6/5N0tlL1jns0sl3ZPFzocprKs=;
        b=VkmcCs9Byf2fe2P01TRhezSxy3aWn4/VnpyluGcQLz/QK4mqzkcrbvSm4Aqf35jROY
         sFI79E2teXnNFDAVZhDZ+CDTJLZ2m0iyl10aA2z0S85xLLAQgWATgFFeVMel8YEPxL2g
         zpUZ9UoSZhTre/9zTeHLyr6w4bWX8zFFOESTtkRI4diz/Qi2Okzk28awMuANOdYF1/GL
         qP4k/+YM3Cy37kSd/r1pFe3RFg4MCeIx4NzQP2KyAZRC0tkAyuBUgW+fpzYa9YP16tL4
         pDNLzRslwQPyZOdUe2/MAELuULIO/KEuuzyeIfAiT/HP90Ug8tWGnW9wXl1RgrarpWz9
         RQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812751; x=1745417551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUYZgkfwAV78Z4x6r6/5N0tlL1jns0sl3ZPFzocprKs=;
        b=SsWWlZvOxfmUpLj4rmdP5cTyjuEu5nl5PlPSiHJOCY9L40wcdg0ZEhsCNI1j6O7wXo
         4JGLv8xADyJdmBM0MXyBWizkwhpynYpyt1lid/5KGqd9F93XmRvS7SQ3LaM5Q23Y5gHF
         BFhtyQ/FIpMKQ9oWzKap8KwZDi+eBrEcr1r86I3mMTefEa/WbRi4eYKkfJJZDzL+Fugw
         zb5nJGimIJCY13NM3ZbBaBFZAMzdoc6t0nrYR0WhXk38CRMlDip+4F1U7qnsA0kq/d7V
         86rCb9FGtc10XI76N3rM3saL/iiB5U3kFrqOCH862a4tXDF30l9N2DkwE/EiEPq1iS1l
         dMlA==
X-Forwarded-Encrypted: i=1; AJvYcCU+e/KaXnem5JfVrOfD0/AlyJlhVichjNFDnWM53eXfLbi63rSA6ojYb3dayqT6hhFSX2/TuLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOL/fHT2l25ncdXrPxkg5/gZVOeGvIxA1FacGrPSA0BFdTkZls
	ldmYr5d48dWPGxCfeXk9Q0vB8YT8K4HuA3co8+sJVoZhjF+ofpVulHo8L2Bd/MY=
X-Gm-Gg: ASbGncu7IpPs9qb7hw5pnL06oTbPyUCXr3XpvNSV/+kS9cddrqak5wktBofNxz25NS4
	5xyoeRQsLQbeSBDbhUx9TmSGJT/+tF/hWiKanhxE1M2vQwJ/XTLkOaYPn88163Sp8T4Ax8oqFO5
	r/6ybe28WH9rncp/Iy2A/O9ez3gtNPq+qf7hmqSLvCZFHJoj3DPKjx6fghyF459v9ARWEhn4yDQ
	4QsLikj/6OlKqzmARF1puYh1llbfSjZ2kcwR1RdsBCvBzrI01diN3CpVTdsqKVQT/2KPg4AHrBF
	wNnYVng4leHk2tzAx7AN1lyvhH5urjiXHGSgP4GeGMwdqg==
X-Google-Smtp-Source: AGHT+IEJ1ZeANIwHFuDY6t3y6GnlsaIDC5gJg8oKFtln1tdudBv3h9RxhlbJSv4sZ46zKC2jgRE1hA==
X-Received: by 2002:a17:906:6a0d:b0:aca:ea78:6415 with SMTP id a640c23a62f3a-acb42cfbe1bmr189059066b.56.1744812750744;
        Wed, 16 Apr 2025 07:12:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f36ef61911sm8536186a12.32.2025.04.16.07.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:12:27 -0700 (PDT)
Date: Wed, 16 Apr 2025 17:12:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org
Subject: [bug report] rxrpc: rxgk: Implement the yfs-rxgk security class
 (GSSAPI)
Message-ID: <Z_-6yKUdJO0yDe9-@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Howells,

Commit 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security
class (GSSAPI)") from Apr 11, 2025 (linux-next), leads to the
following Smatch static checker warning:

	net/rxrpc/rxgk_app.c:240 rxgk_extract_token()
	error: uninitialized symbol 'ec'.

net/rxrpc/rxgk_app.c
    180 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
    181                        unsigned int token_offset, unsigned int token_len,
    182                        struct key **_key)
    183 {
    184         const struct krb5_enctype *krb5;
    185         const struct krb5_buffer *server_secret;
    186         struct crypto_aead *token_enc = NULL;
    187         struct key *server_key;
    188         unsigned int ticket_offset, ticket_len;
    189         u32 kvno, enctype;
    190         int ret, ec;
    191 
    192         struct {
    193                 __be32 kvno;
    194                 __be32 enctype;
    195                 __be32 token_len;
    196         } container;
    197 
    198         /* Decode the RXGK_TokenContainer object.  This tells us which server
    199          * key we should be using.  We can then fetch the key, get the secret
    200          * and set up the crypto to extract the token.
    201          */
    202         if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) < 0)
    203                 return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
    204                                         rxgk_abort_resp_tok_short);
    205 
    206         kvno                = ntohl(container.kvno);
    207         enctype                = ntohl(container.enctype);
    208         ticket_len        = ntohl(container.token_len);
    209         ticket_offset        = token_offset + sizeof(container);
    210 
    211         if (xdr_round_up(ticket_len) > token_len - 3 * 4)
    212                 return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
    213                                         rxgk_abort_resp_tok_short);
    214 
    215         _debug("KVNO %u", kvno);
    216         _debug("ENC  %u", enctype);
    217         _debug("TLEN %u", ticket_len);
    218 
    219         server_key = rxrpc_look_up_server_security(conn, skb, kvno, enctype);
    220         if (IS_ERR(server_key))
    221                 goto cant_get_server_key;
    222 
    223         down_read(&server_key->sem);
    224         server_secret = (const void *)&server_key->payload.data[2];
    225         ret = rxgk_set_up_token_cipher(server_secret, &token_enc, enctype, &krb5, GFP_NOFS);
    226         up_read(&server_key->sem);
    227         key_put(server_key);
    228         if (ret < 0)
    229                 goto cant_get_token;
    230 
    231         /* We can now decrypt and parse the token/ticket.  This allows us to
    232          * gain access to K0, from which we can derive the transport key and
    233          * thence decode the authenticator.
    234          */
    235         ret = rxgk_decrypt_skb(krb5, token_enc, skb,
    236                                &ticket_offset, &ticket_len, &ec);
                                                                    ^^^
ec is only sometimes set here.

    237         crypto_free_aead(token_enc);
    238         token_enc = NULL;
--> 239         if (ret < 0)
    240                 return rxrpc_abort_conn(conn, skb, ec, ret,
                                                           ^^
This is Undefined Behavior.

    241                                         rxgk_abort_resp_tok_dec);
    242 
    243         ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,
    244                                                     ticket_len, _key);
    245         if (ret < 0)

regards,
dan carpenter

