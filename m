Return-Path: <netdev+bounces-184352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26721A94EC8
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9851188FEE9
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4E20E708;
	Mon, 21 Apr 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W2B8KIwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5119ADA4
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228353; cv=none; b=gwLkyiZKwgne2AErLFjwd+Pg7HcXt3MBa04awP3ZDR3jhB/WsT0H0AEWqiGCHXuxKIo0i7qO/SecU5zviBteJunVctKLfM0aT+Y2WMfTDIap8arJEcOaJjEdTX0lzXL4Crzk2MW5pHB94XaC/RkF+w7XukAWATrODU2MhUvKT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228353; c=relaxed/simple;
	bh=cMq6OAmBxcf/lG7hdDQdjFnvXFyPqX8uaX9LXRx5UhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJugKBQJ0J//lO0DqQb/ACBzSdVIBYmrk4WhT0PlILqPzHFJiN1LKYLawi9itaRI8T4bUeksrEXzO477xfGpby3aZpW5I3Sojcljz6NtTekHI72h3zBac+IJbuiKLc+Sy1g2ykFOWjDVUxbz5/lvS8zI7C6KSay3nlIISLTgbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W2B8KIwg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af590aea813so4497383a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745228351; x=1745833151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RU9lBd2/J5bzB21zQw6ghXfLHHeW5jTZf+wK1I/zlBQ=;
        b=W2B8KIwgIA8QFLmX7COvaVsBkXWp8i6kWLi0577GZ65e1opEPF4YWUaB2bbZ/m0lOw
         +ZqKPwqcDxgrsl49Ep1w3mojlO7zldxZBEQib/nXUv7aJHQ5cMDfQHNfVyz3umMk098j
         K0jSmaUhNEw1IwBVA5u/X1RsvwilcyAN1QKlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228351; x=1745833151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU9lBd2/J5bzB21zQw6ghXfLHHeW5jTZf+wK1I/zlBQ=;
        b=wCy7JT7ktIYcdekWAcP7/9Tag16NwXyh9bN+/j1seRI6+vsEcDmVPtVdvuHRY7j1Mv
         gJgN+JkeJ/3T/JMjWCjwEzQYP3fUZrWpqOyV1fVxCIaMiqEtnNtWQg2Vjp0OASm9845R
         fXeh8W3PG3/5XngKVFzCVBcVUQYsIoHYyA83sc15uX7NlpLi3ZB2RR+M7hL+VZZpHNxz
         XrxYOa/QnWQsNJmo1/qZpjZjB0G8AMIfYOpJcrbwIMMaGtKDcliLOfY+v7d4x9+olPYE
         8p+073Y5jhgdg0zMY4RP06Tr1/sjc/kG/h3LyGIj/xjK/pOycGMLcKvwWRCec0Z8aM6a
         SGzg==
X-Forwarded-Encrypted: i=1; AJvYcCWt+iYKVF2JV/V0STQq6cGA8Jo0QMWFl94ljqE6MaT+QfPZKXI+2lKzheHRFaHA0ICwtcdLn5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAs0PuK0jgq4xYRaf2bWCTNIS+jBMwzOHPQLQnz0Ih3YloLCO
	fUZeyHrJjy9YrToytMTN56mptxcLCndFbAZLVkFJe7PG2iVD0YdRBo8GbX8j82rGU0aBTtFaIDI
	ZvUFy644V/v/Crxmt5ma2PEPUTgXSX90AfrW7
X-Gm-Gg: ASbGncv5jTGbPaKwSwY5oR4cTFxdYXs7d/J+f+wyXZ8L07fWWLkV/LuGOx8kt4ks5qw
	0A/Io5grNoF1/ediwWUY80Xj6NG/kQpKylpqmMeXa3onBet9TUFHHseQFrt6VOzmPa/UfNClDRB
	vgsqodo0iA3XrczOlk6HD3wOk=
X-Google-Smtp-Source: AGHT+IHRMAycn8F/dC0uK+L+wQr+ItXuOw9nviGxeiyo9rm6t8CzCXNy3D7/uiLvgoAnSg5LY78RBUqmBFGz7ggtXyc=
X-Received: by 2002:a17:903:3bcc:b0:223:3eed:f680 with SMTP id
 d9443c01a7336-22c50d44a6bmr173666385ad.18.1745228351307; Mon, 21 Apr 2025
 02:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417160141.4091537-1-vadfed@meta.com>
In-Reply-To: <20250417160141.4091537-1-vadfed@meta.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 21 Apr 2025 15:08:59 +0530
X-Gm-Features: ATxdqUFHS6fRGJ7lNDBD261kzj-m-lJTfbRnhpIJQmgQ-bSbHo5CBx2CygasV6Y
Message-ID: <CALs4sv1sKLABmzHNj3DuMRYjJBm2_t2WZttr56DfHozpA7kqrQ@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: improve TX timestamping FIFO configuration
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>, 
	netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f32e32063346a375"

--000000000000f32e32063346a375
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:31=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> Reconfiguration of netdev may trigger close/open procedure which can
> break FIFO status by adjusting the amount of empty slots for TX
> timestamps. But it is not really needed because timestamps for the
> packets sent over the wire still can be retrieved. On the other side,
> during netdev close procedure any skbs waiting for TX timestamps can be
> leaked because there is no cleaning procedure called. Free skbs waiting
> for TX timestamps when closing netdev.
>
> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX =
packets to 4")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2:
> * move clearing of TS skbs to bnxt_free_tx_skbs
> * remove spinlock as no TX is possible after bnxt_tx_disable()
> * remove extra FIFO clearing in bnxt_ptp_clear()
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 28 ++++++++++++++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>  3 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index c8e3468eee61..2c8e2c19d854 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3414,6 +3414,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
>
>                 bnxt_free_one_tx_ring_skbs(bp, txr, i);
>         }
> +
> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
>  }
>
>  static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_i=
nfo *rxr)
> @@ -12797,8 +12800,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool =
irq_re_init, bool link_re_init)
>         /* VF-reps may need to be re-opened after the PF is re-opened */
>         if (BNXT_PF(bp))
>                 bnxt_vf_reps_open(bp);
> -       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> -               WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
>         bnxt_ptp_init_rtc(bp, true);
>         bnxt_ptp_cfg_tstamp_filters(bp);
>         if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index 2d4e19b96ee7..197893220070 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_in=
fo *ptp_info)
>         return HZ;
>  }
>
> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
> +{
> +       struct bnxt_ptp_tx_req *txts_req;
> +       u16 cons =3D ptp->txts_cons;
> +
> +       /* make sure ptp aux worker finished with
> +        * possible BNXT_STATE_OPEN set
> +        */
> +       ptp_cancel_worker_sync(ptp->ptp_clock);
> +
> +       ptp->tx_avail =3D BNXT_MAX_TX_TS;
> +       while (cons !=3D ptp->txts_prod) {
> +               txts_req =3D &ptp->txts_req[cons];
> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
> +                       dev_kfree_skb_any(txts_req->tx_skb);

For completeness, should we not set txts_req->tx_skb =3D NULL here, just
like we did in bnxt_ptp_clear which is now gone.

> +               cons =3D NEXT_TXTS(cons);
> +       }
> +       ptp->txts_cons =3D cons;
> +       ptp_schedule_worker(ptp->ptp_clock, 0);
> +}
> +

--000000000000f32e32063346a375
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKKPqtdOSOn5MQMimVs7yEUgW3CJinVQ
dRoRvWMi+n+6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQy
MTA5MzkxMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAB9EQBUIK9VOQ5C8vlOeLIuEMAMqkef0V5AtPBif2B3eeKUU0Lj6Z2GMMSGrgYS5fN5i
kUwq1Hc1FqrsWv+aD7PCPWbL8/RBIPqdtWwl69gb5s7rCTFZz2UZ/AVZ+o1AWWu68clPcjFKAsIF
r9YWPoG6X2u/KEppnvqwhriGSPKIk5uoEumiB444Q451U9edbKQhCKpfdItSP5v/F9wUMs2hel2B
fwGrL3qotiDKAjZcruBUDdrOHD+T5wc9wAiVHJ1RGLxTWGyWWpRZ5n1+k1dDBI5rZzf/JBqc5CPu
8fMrFC0w/bEe4RcaM6uhQbSTqKqDUdOZYQZnWvmyDCC6bco=
--000000000000f32e32063346a375--

