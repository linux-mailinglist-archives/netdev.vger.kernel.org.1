Return-Path: <netdev+bounces-214705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2AB2AF7E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE245819B5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F72773C7;
	Mon, 18 Aug 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6DKpFWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513235A29B;
	Mon, 18 Aug 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538411; cv=none; b=tw3eMLLT9J6be1z4XoEEkT4lJT2WVBz9chXK34hxUUXem4g6k3lDIXgsZhmDtDd8Uuk+MBolht44BrdhXTTeNo2n7UGHJeIhYJiBRVeL3Oc+6gmQtUZtJX1CHcruZw637wH23WXrpzeO+Ogbe10yDwN0DY/cClVH5//PSlwXoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538411; c=relaxed/simple;
	bh=A2NsIcg1V7edxkeV7A3sJ+VRxPdOcnPyky4g5/mQMfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2qnSBbDOsISrcGgDMhZvxMSF3bHuJDhnlffBkUI7h7iGfS94ViJLkWZXbnmfc8F4rMbiREcPqtCGgdFmQjRF6ri5wtJkM1wNMUXGLwEqoTG2nnGfhr++CrebdnHVNo6KzxNVreOaROAD1vwP1JspzUQSiH2hMEH2zbhjO5AN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6DKpFWE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266d2d9eso3285363a91.0;
        Mon, 18 Aug 2025 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755538409; x=1756143209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dggd3LkH5i9MRkV2z8hWvgrPCcqA4YBYEr7TKwboQsQ=;
        b=k6DKpFWEoe06/kjSUUTJCnHjR8Vai/dSzjmRd9lvoWVlUU/oN6yZtFY1io8bPGWcFe
         SItqhn1OBTG9nH9nSeeGJbWlMlaWVlRDRjstN8o8/0OsMnDpOvELquDatbQhou01yIiP
         AIx8vPHllBZc6KlEovRInwQgNQJYVHjgglIcYO7heD3Doauj/TjtN69dWRIQA7Y5+UmI
         SFR6tsu/4AoRXPWGoHX8Y3pFLTBYpRKlXqLDwLAb9/b01gSaAyMmJHLP8fFO6Wa+J4kQ
         cLAyRefVjAHwHblRKKWGsPO1fqH9QK0vJhBVeSy0vKiIgqxAxqOEUYcNygav6k0cjdXc
         KWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538409; x=1756143209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dggd3LkH5i9MRkV2z8hWvgrPCcqA4YBYEr7TKwboQsQ=;
        b=Q5kPpergPmLUi/AIZ8aL36kcrPVlUWV/97CIusQ+s0lHRZ2J8jhscsRwaIesxu4mGk
         PRq2NNiBM5mkCNtn7rNLqhfcT0uLuDSKPA+vOLIuRK3gYlrQN7xTqR++zxW1NSGpbkF3
         1bbwAm2L8g/8YJmVujXQ+lgbJlxVkiBUgxCFRT7XxsYq4FLExb6bCGIfqxpgvFQkjNNq
         RRGy1sp5IQjY3S2/1bCxnfZ3xVROzGrWAtbFTFro3RnGPfZNhTnD6p/zmcQ4xm4EAsrW
         VBUaF+ucUafrrQ//NTTPge4mXbmXx28BRiH9K/eQC4UwokvSZQ7YUUMBaqdYiF9W0zl5
         OVbg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8Zz3r5Zq6LzqCxsYeZr/IDpgsXFefrBEoOcvz/dnxlddWD5aB5Wjd4neQT9Anl0EBHdfJFShriI7clVF@vger.kernel.org, AJvYcCXca2nYstFk63D2BA6pvqI3erFQmitLbDcopMfYxit7HYGRJwx9z+ewNO+PsFokE4rHSfRAu1v5iFu0@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDFSN46m0MxScwL3MbJoDsjgFKaQwowH+UdqDUxsPcbbOd4mW
	ynUUBjKOQgL0lJhuUYAA5IEq35n++cjZsT1vTV141oUGvJgsM65pbsxtpilr7g0zeTlebv6/Xo4
	7yzI1Cflyod1OyDoC6xzMlq1X226mBwY=
X-Gm-Gg: ASbGncuh3fZ8fMy7uM0Ye8F7SmXHbwIkYbjywS3waKh6gONAwKz61Cv2TnvI1Io690O
	f01zTfnmafW7aNIChJEUEmN23Rs7kuZiF9x6C3raPB5E8Ra5GDGgcf+PuLjRB7Zdpz8KcCkRn8o
	4RdYtJ48T1tVYuwRDg/cITKE2Lfsmcpt1P3HypKS16YjjCShCigbAW3DUJVZOSDnGFRLfcgba5l
	W7uFDCWRnr4fCD1uxk9hzEF1uzfbYNfDxHJTgFz
X-Google-Smtp-Source: AGHT+IEIvEqlY6hy2gXnuzZ42Ohw3RH859FU7WdGZFr3bJQwfaJBBUgRSD5AJykHVfcnrOzfydi/k81O4AG/UJtdRTs=
X-Received: by 2002:a17:90b:2f4d:b0:312:26d9:d5a7 with SMTP id
 98e67ed59e1d1-3234dc3a458mr13978984a91.20.1755538408882; Mon, 18 Aug 2025
 10:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818162445.1317670-1-mmyangfl@gmail.com> <20250818162445.1317670-3-mmyangfl@gmail.com>
 <2ac97f29-bfc2-4674-9569-278bb4492676@lunn.ch>
In-Reply-To: <2ac97f29-bfc2-4674-9569-278bb4492676@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 19 Aug 2025 01:32:52 +0800
X-Gm-Features: Ac12FXzNE_KrxMmsjOEUKM7XzmTbKs9oi25CPDYboQArNsZCNamMQ-IC-SwAv68
Message-ID: <CAAXyoMNjukd-=cMDLiupNDYv1NLreWkCQufhAu_1y3N0udUrQw@mail.gmail.com>
Subject: Re: [net-next v4 2/3] net: dsa: tag_yt921x: add support for Motorcomm
 YT921x tags
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:07=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static struct sk_buff *
> > +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +     struct dsa_port *dp =3D dsa_user_to_port(netdev);
> > +     unsigned int port =3D dp->index;
> > +     struct dsa_port *partner;
> > +     __be16 *tag;
> > +     u16 tx;
> > +
> > +     skb_push(skb, YT921X_TAG_LEN);
> > +     dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> > +
> > +     tag =3D dsa_etype_header_pos_tx(skb);
> > +
> > +     /* We might use yt921x_priv::tag_eth_p, but
> > +      * 1. CPU_TAG_TPID could be configured anyway;
> > +      * 2. Are you using the right chip?
> > +      */
> > +     tag[0] =3D htons(ETH_P_YT921X);
> > +     /* Service VLAN tag not used */
> > +     tag[1] =3D 0;
> > +     tag[2] =3D 0;
> > +     tx =3D YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
> > +     if (dp->hsr_dev)
> > +             dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
> > +                     tx |=3D YT921X_TAG_TX_PORTn(partner->index);
>
> As far as i remember, this was not in v1. When i spotting this in v2
> that made me comment you should not add new features in revision of a
> patch.
>
> Does the current version of the DSA driver support hsr? Is this
> useful? Maybe it would be better to add hsr support as a follow up
> patch?

Sorry, this was forgotten to undo.


> > +static struct sk_buff *
> > +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +     unsigned int port;
> > +     __be16 *tag;
> > +     u16 rx;
> > +
> > +     if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> > +             return NULL;
> > +
> > +     tag =3D (__be16 *)skb->data;
> > +
> > +     /* Locate which port this is coming from */
> > +     rx =3D ntohs(tag[1]);
> > +     if (unlikely((rx & YT921X_TAG_PORT_EN) =3D=3D 0)) {
> > +             netdev_err(netdev, "Unexpected rx tag 0x%04x\n", rx);
> > +             return NULL;
> > +     }
> > +
> > +     port =3D FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
> > +     skb->dev =3D dsa_conduit_find_user(netdev, 0, port);
> > +     if (unlikely(!skb->dev)) {
> > +             netdev_err(netdev, "Cannot locate rx port %u\n", port);
> > +             return NULL;
> > +     }
>
> O.K. Stop. Think.
>
> You changed the rate limiting to an unlimiting netdev_err().
>
> What is the difference? Under what conditions would you want to use
> rate limiting? When would you not use rate limiting?
>
> Please reply and explain why you made this change.
>
>         Andrew

I copied the limited version from tag_vsc73xx_8021q.

Under no conditions I expect either of them to appear: it is the case
when I did my own tests; unless something really bad happens, like
pouring a cup of coffee over your device.

I know rate limiting is a way to prevent flooding the same message
over dmesg, but if an event never happens, I would consider two
methods are exchangeable. Theoretically if an event never happens, no
warnings would ever be needed, but I placed one here in case you
destroy your device accidentally.

Thus if you think rate limiting is not appropriate here, I would fix
it with another.

