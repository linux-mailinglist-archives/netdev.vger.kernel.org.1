Return-Path: <netdev+bounces-139247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B99B1264
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B0E2837C6
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBAD1D4148;
	Fri, 25 Oct 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YqHK5lot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B618C320
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894428; cv=none; b=SYBq7JJCIIqSbzQ8xdyLgs37LIZSHk2wRpNCWHGVh/FyG6yUMA9nd+QAIirDCOY9+rDJx4LY7Q2iT+8xVrPSjzzWu3GbtWxbpwe/njLzrF1/mGtOdaUe9QgjFdIlwC5lQYvW3ray9axCiv2aDFstoMzUZuoHiFMPFzgdhIrhKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894428; c=relaxed/simple;
	bh=RFY7upe9ArgAj7MUGltQe9ivuRg7cc7LEa277JK3FsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mdq5/hbEBofPhyp4bJvFpoPyYRg0aske9OZrTc4NwrpEGOMUOzPLitt0Gbw9++o94IGEv41+kJw3nSdrHc3FzPPTuGi2Mz74gXGSjieAuR5qREUoj5r+tOu/X9ks54zeHrbZH0athgC6e8ciXnMQk6hAXByn4NE0MlsNiXkCmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YqHK5lot; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so2983003a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729894425; x=1730499225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIKYJCDyI1tO5qyY7U7txvCPyBvZdA59vfJVKZux4Xo=;
        b=YqHK5lotz/sU2+K1juvj/9RF9sWeCnd5RuX90v7Cp/zc8cWp2G9kF70vDY9hFhNSXD
         LcGgyjkw0HfUhrg9f5zL7N2Ckwcy7S39seQ7Rwi+PQv3xPZGjRQy1H3D9BknvAlDSj+q
         yEaSGOnljh/X+Rck856GwZRMkOOjEXN3ruvfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729894425; x=1730499225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIKYJCDyI1tO5qyY7U7txvCPyBvZdA59vfJVKZux4Xo=;
        b=GQfMBBTiModf4dKPAWkr5pwp24rSHEkKuKdIZjUigQvKTKziYSKDXe69C126qRn8Qo
         pBettGUmy0VAreC4fEqZtduXoVTVRzWdEFv5PqnWU1UTDvaoKowQKOxqZ3JjgMVTytmp
         L5wakG6nu9Op4EVESz9+n6HvrH/CdK3U1hTM/0yAiqtDFL0nzg4VfYZWthD/eNMaMV1h
         KM6OLxFNcJ96QK75mIgcRj2wWwjhhXIHD9Gdn6F3N5bz8FBToUBRzvwRsDRSsUb4A7cd
         Dl6wPdRSuSIWIJ54+1UuDPd6jgeMGHig2KvckUenq0XZG+JfwqTYdhjHkePQINWagFZu
         2BxA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ55lD8yMUP39kA5sYsS9zYP6ph3DM7BaiPWf5tI35NMJoI9xXHvAnwEhxwp0MatDyZdOCkTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5u+RcLhUuwoPP+ZmLkeQnBNMFIrrwir7d3jriwlECSwwO/eT
	ifFLV9o7mOwU7z78XNX/37t66pVKTRI+58a/q3tj4Hs+qoVnjblUUYEOguHlt1elwj6lAfn/sSW
	2OrxN5r01UA5HT1oO0LZsEtFebK7itdGlUsuL
X-Google-Smtp-Source: AGHT+IEUjRwih1dL5pGtZ30RV/Dp1EQQHCy4jRLxz/HtNZUX9j9dJJWtZXUUOuK8Ur/u7FHsF2tVJbZ0uZN9Iq9bJ6o=
X-Received: by 2002:a05:6402:280f:b0:5cb:674f:b0fc with SMTP id
 4fb4d7f45d1cf-5cbbf947c01mr481835a12.23.1729894424503; Fri, 25 Oct 2024
 15:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025194753.3070604-1-vadfed@meta.com> <CACKFLikgQxsYQxkMZdXDusS=0=rZi8g9Fn6-nEnVw+g-hgzf4g@mail.gmail.com>
 <e89385ae-7d77-4890-8c80-b5904ac394b4@linux.dev>
In-Reply-To: <e89385ae-7d77-4890-8c80-b5904ac394b4@linux.dev>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 25 Oct 2024 15:13:33 -0700
Message-ID: <CACKFLinHAXcXF45NTJueBg8JDbJfPTrPZiwHzR71K4LtvHxLVw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] bnxt_en: cache only 24 bits of hw counter
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b352e10625546e07"

--000000000000b352e10625546e07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:53=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 25/10/2024 22:31, Michael Chan wrote:
> > On Fri, Oct 25, 2024 at 12:48=E2=80=AFPM Vadim Fedorenko <vadfed@meta.c=
om> wrote:
> >>
> >> This hardware can provide only 48 bits of cycle counter. We can leave
> >> only 24 bits in the cache to extend RX timestamps from 32 bits to 48
> >> bits. This make cache writes atomic even on 32 bit platforms and we ca=
n
> >> simply use READ_ONCE()/WRITE_ONCE() pair and remove spinlock. The
> >> configuration structure will be also reduced by 4 bytes.
> >
> > ptp->old_time serves 2 purposes: to cache the upper 16 bits of the HW
> > counter and for rollover check.  With this patch reducing
> > ptp->old_time to 24 bits, we now use the upper 16 bits for the cache
> > and the next 8 bits for the rollover check.  I think this will work.
> > But since the field is now 32-bit, why not use the full 32 bits
> > instead of 24 bits?  Thanks.
>
> As you confirmed that the HW has 48 bits of cycle counter, we have to
> cache 16 bits only. The other 8 bits are used for the rollover check. We
> can even use less bits for it. What is the use for another 8 bits? With
> this patch the rollover will happen every ~16 ms, but will be caught
> even till ~4s. If we will cache upper 32 bits, the rollover will happen
> every 64us and we will have to update cache value more often. But at the
> same time it will not bring any value, because the upper limit will
> still be ~4s. That's why I don't see any benefits of using all 32 bits.

I agree the extra bits have no value other than to fill the 32-bit
field.  But it should not affect the frequency of caching
ptp->old_time.  It should be updated in bnxt_ptp_ts_aux_work() at a
fixed interval (1 second).

--000000000000b352e10625546e07
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG1I2Vqa/NlJAJuMkODLg1YWNuGIzc60
vAAAGolBekv9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAy
NTIyMTM0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA9Cb7wAyuy+Dx+mzlQQEPUf9S7Lu8LmJ89OVbV+krYBjpPx4AZ
/1WU7LMQSe6TuCOkUBPRwK0NzGdpLLWJ8eHSaXa3QNqkm+FXPKunW5XogqWZwYKTTAIlYVCtCV/2
iPf6aMtue57SJ1yvWTY9nWtycROB2XoLxJ/s+okfWkeI+/zpoNPTAkGljagUOUdtmi96XSAZnrs6
3xcDc/Bh62B4zYIz0Ne7rdAQyjlfhZrFkajP6FsMFCEdpQbynJzAYHBhZzq19jYHTPvdSyOuX6el
25s9jXsMiT8V6oq+/JgR+/DxxJIuhLaEvjahdP4aZJDisPoWdHgL4zSnbedyn+Wu
--000000000000b352e10625546e07--

